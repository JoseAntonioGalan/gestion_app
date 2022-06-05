// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_app/screens/category_selection_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _descripcionController = TextEditingController();
  final _descripcionFocus = FocusNode();
  String category = "";
  String value = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Categorias",
          style: TextStyle(color: Colors.deepPurple),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.deepPurple,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _categorySelector(),
            _name(),
            _tipe(),
            _currentValue(),
            _numpad(),
            _submit(),
          ],
        ),
      ),
    );
  }

  Widget _categorySelector() {
    return Container(
      height: 80,
      child: CategorySelectionWidget(
        // ignore: prefer_const_literals_to_create_immutables, duplicate_ignore
        categories: {
          "shopping": Icons.shopping_cart,
          "Alcohol": FontAwesomeIcons.beer,
          "Fast Food": FontAwesomeIcons.hamburger,
          "Bills": FontAwesomeIcons.wallet,
          "Wine": FontAwesomeIcons.wineBottle,
          "Water": FontAwesomeIcons.water,
          "Movile": FontAwesomeIcons.mobile,
          "Pedro": FontAwesomeIcons.user
        },
        onValueChanged: (newCategory) { category = newCategory;},
      ),
    );
  }

  Widget _name() => GestureDetector(
        onTap: () {
          _descripcionFocus.unfocus();
        },
        child: Container(
          height: 80,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _descripcionController,
              focusNode: _descripcionFocus,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Introduce descripcion",
                  label: Text("Descripcion")),
              
            ),
          ),
        ),
      );

  //80
  Widget _tipe() {
    return Container(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: 180,
              decoration: BoxDecoration(color: Colors.green.shade50),
              child: MaterialButton(
                  child: Text(
                    "Ingreso",
                    style:
                        TextStyle(fontSize: 20.0, color: Colors.green.shade500),
                  ),
                  onPressed: () {})),
          Container(
            width: 180,
            decoration: BoxDecoration(color: Colors.red.shade50),
            child: MaterialButton(
              child: Text(
                "Gasto",
                style: TextStyle(fontSize: 20.0, color: Colors.red.shade500),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _currentValue() {
    return Container(
        height: 120,
        child: Center(
          child: Text(
            value + "€",
            style: TextStyle(
                fontSize: 50,
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  Widget _num(String text, double height) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {

          String primerCaracter = value.substring(0);

          if(primerCaracter == "0" && text == "0"){
            return ;
          }else{
            if(primerCaracter == "0"){
              if(text == ","){
                value = "0,";
              }else{
                value = text;
              }
            }else{
              if(text == ","){
                if(!value.contains(text)){
                  value = value + ",";
                } 
              }else{
                value = value + text;
              }
            }
          }

          
        });
      },
      child: Container(
          height: height,
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontSize: 40, color: Colors.deepPurple),
          ))),
    );
  }

  // 322
  Widget _numpad() {
    return Container(
      height: 322,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var height = constraints.biggest.height / 4;
        return Table(
          border: TableBorder.all(color: Colors.grey, width: 1.0),
          children: [
            TableRow(children: [
              _num("1", height),
              _num("2", height),
              _num("3", height),
            ]),
            TableRow(children: [
              _num("4", height),
              _num("5", height),
              _num("6", height),
            ]),
            TableRow(children: [
              _num("7", height),
              _num("8", height),
              _num("9", height),
            ]),
            TableRow(children: [
              _num(",", height),
              _num("0", height),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if(value.length == 1){
                      value = "0";
                    }else{
                      value = value.substring(0, value.length - 1);
                    }
                  });
                },
                child: Container(
                    height: height,
                    child: Center(
                        child: Icon(
                      Icons.backspace,
                      color: Colors.deepPurple,
                      size: 40,
                    ))),
              )
            ])
          ],
        );
      }),
    );
  }

  //50
  Widget _submit() {
    return Builder(builder: (BuildContext context) {
      return Container(
          height: 51.0,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.deepPurple),
          child: MaterialButton(
            child: Text(
              "Añadir",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: () {
              String resultado = value.replaceAll(",", ".") ;
              double valorFinal = double.parse(resultado);
             if(valorFinal > 0 && category.isNotEmpty && _descripcionController.text.isNotEmpty){
               // ignore: avoid_single_cascade_in_expression_statements
               FirebaseFirestore.instance..collection('gastos')
                .doc()
                .set(
                  {
                    "anyo": DateTime.now().year,
                    "dia": DateTime.now().day,
                    "mes": DateTime.now().month,
                    "nombre": _descripcionController.text,
                    "valor": valorFinal,
                    "categoria": category});
              Navigator.of(context).pop();
             }else if (_descripcionController.text.isEmpty){
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('La descripcion no puede estar vacía')),);
             }else if( valorFinal == 0){
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('La ingreso/gasto no puede ser 0')),);
             }else if(category.isEmpty){
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Debe seleccionar una categoria')),);
             }
            },
          ));
    });
  }
}
