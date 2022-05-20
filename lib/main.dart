import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestion_app/estados/login_state.dart';
import 'package:gestion_app/firebase_options.dart';
import 'package:gestion_app/screens/add_page.dart';
import 'package:gestion_app/screens/home_page.dart';
import 'package:gestion_app/screens/login_page.dart';
import 'package:gestion_app/screens/register_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
      create: (BuildContext context) => LoginState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          "/": (BuildContext context) {
            var estado = context.watch<LoginState>();
            if (estado.isLoggedIn()) {
              return MyHomePage();
            } else {
              // ignore: prefer_const_constructors
              return LoginPage();
            }
          },
          "/register_page": (context) => const RegisterPage(),
          "/login_page": (context) => const LoginPage(),
          "/add_page": (context) => AddPage(),
        },
      ),
    );
  }
}
