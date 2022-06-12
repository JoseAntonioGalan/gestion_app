// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_app/estados/login_state.dart';
import 'package:gestion_app/screens/month_widget.dart';
import 'package:gestion_app/utils/dias_mes.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _controller;
  int currentPage = DateTime.now().month-1;
  late Stream<QuerySnapshot> _query;

  late List<QueryDocumentSnapshot<Object?>> datos;

  @override
  void initState() {
    super.initState();


    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  Widget _bottomAction(IconData icon, VoidCallback function) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Icon(icon),
      ),
      onTap: function,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<LoginState>(
      builder: (context, value, child) {
        var user = Provider.of<LoginState>(context,listen: false).currentUser();
        _query = FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .collection('gastos')
                .where('mes', isEqualTo: currentPage + 1)
                .snapshots();
              
      return Scaffold(
        bottomNavigationBar: BottomAppBar(
          notchMargin: 8.0,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // ignore: deprecated_member_use
              _bottomAction(FontAwesomeIcons.moneyBillTrendUp, () {
                Navigator.of(context).pushNamed("/add_entry");
              }),
              _bottomAction(FontAwesomeIcons.chartPie, () {}),
              SizedBox(width: 48.0),
              _bottomAction(FontAwesomeIcons.wallet, () {}),
              _bottomAction(FontAwesomeIcons.arrowRightFromBracket, () {
                Provider.of<LoginState>(context, listen: false).logout();
              }),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // ignore: avoid_print
            Navigator.of(context).pushNamed("/add_page");
          },
        ),
        body: _body(),
      );
      }
    );
  }

  Widget _body() {
    return SafeArea(
        child: Column(
      children: <Widget>[
        _selector(),
        StreamBuilder(
            stream: _query,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                datos = snapshot.data!.docs;
                return MonthWidget(
                  days: daysInMonth(currentPage + 1),
                  datos: datos,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ],
    ));
  }

  Widget _pageItem(String nombre, int position) {
    // ignore: prefer_typing_uninitialized_variables
    var _alignment;

    final selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    );

    final unselected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.deepPurple.withOpacity(0.4),
    );

    if (position == currentPage) {
      _alignment = Alignment.center;
    } else if (position > currentPage) {
      _alignment = Alignment.centerRight;
    } else {
      _alignment = Alignment.centerLeft;
    }

    return Align(
      alignment: _alignment,
      child: Text(
        nombre,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPage) {
          setState(() {
            var user = Provider.of<LoginState>(context,listen: false).currentUser();
            currentPage = newPage;
            _query = FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .collection('gastos')
                .where('mes', isEqualTo: currentPage + 1)
                .snapshots();
          });
        },
        controller: _controller,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          _pageItem("Enero", 0),
          _pageItem("Febrero", 1),
          _pageItem("Marzo", 2),
          _pageItem("Abril", 3),
          _pageItem("Mayo", 4),
          _pageItem("Junio", 5),
          _pageItem("Julio", 6),
          _pageItem("Agosto", 7),
          _pageItem("Septiembre", 8),
          _pageItem("Octubre", 9),
          _pageItem("Noviembre", 10),
          _pageItem("Diciembre", 11),
        ],
      ),
    );
  }
}
