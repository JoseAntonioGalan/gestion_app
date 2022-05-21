// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_app/screens/category_selection_widget.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _descripcionController = TextEditingController();
  final _descripcionFocus = FocusNode();
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
    return Column(
      children: <Widget>[
        _categorySelector(),
        _name(),
        _tipe(),
        _currentValue(),
        _numpad(),
        _submit()
      ],
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

  Widget _tipe() => Placeholder(fallbackHeight: 80);

  Widget _currentValue() => Placeholder(
        fallbackHeight: 120,
      );

  Widget _numpad() => Expanded(
        child: Placeholder(),
      );

  Widget _submit() => Placeholder(
        fallbackHeight: 50,
      );
}
