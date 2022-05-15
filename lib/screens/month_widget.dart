// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_app/screens/graph_widget.dart';

// ignore: must_be_immutable
class MonthWidget extends StatefulWidget {
  final List<QueryDocumentSnapshot<Object?>> datos;
  final double total;
  final List<double> perDay;
  final Map<String, double> categorias;
  MonthWidget({Key? key, required this.datos})
      : total = datos.map((e) => e['valor']).fold(0.0, (a, b) => a + b),
        perDay = List.generate(30, (index) {
          return datos
              .where((doc) => doc['dia'] == (index + 1))
              .map((doc) => doc['valor'])
              .fold(0.0, (a, b) => a + b);
        }),
        categorias = datos.fold({}, (Map<String, double> map, document) {
          if (!map.containsKey(document['categoria'])) {
            map[document['categoria']] = 0.0;
          }
          map[document['categoria']] =
              (map[document['categoria']]! + document['valor']);
          return map;
        }),
        super(key: key);

  @override
  State<MonthWidget> createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.categorias);
    return Column(
      children: <Widget>[
        _dineroTotal(),
        _graph(),
        Container(
          color: Colors.white10,
          height: 24.0,
        ),
        _list(),
      ],
    );
  }

  Widget _dineroTotal() {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        Text(
          "${widget.total.toStringAsFixed(2)}\€",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        Text(
          "Total Gastos",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.deepPurple),
        ),
      ],
    );
  }

  Widget _graph() {
    // ignore: sized_box_for_whitespace
    return Container(height: 250.0, child: GraphWidget(data: widget.perDay));
  }

  Widget _list() {
    return SizedBox(
      height: 318,
      child: ListView.separated(
        itemCount: widget.categorias.keys.length,
        itemBuilder: (BuildContext context, int index) {
          var key = widget.categorias.keys.elementAt(index);
          var data = widget.categorias[key];
          // ignore: deprecated_member_use
          return _item(FontAwesomeIcons.shoppingCart, key,
              100 * data! ~/ widget.total, data);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.white10,
            height: 8.0,
          );
        },
      ),
    );
  }

  Widget _item(IconData icono, String nombre, int porcentaje, double precio) {
    return ListTile(
      leading: Icon(
        icono,
        size: 32.0,
      ),
      title: Text(
        nombre,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      subtitle: Text(
        "$porcentaje% of gatos",
        style: TextStyle(fontSize: 16.0, color: Colors.grey),
      ),
      trailing: Container(
          decoration: BoxDecoration(
              color: Colors.deepPurpleAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$precio\€",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
          )),
    );
  }
}
