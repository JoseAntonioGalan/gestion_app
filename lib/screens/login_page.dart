import 'package:flutter/material.dart';
import 'package:gestion_app/estados/login_state.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text("Pulsame"),
        onPressed: () {
          context.read<LoginState>().login();
          print("pulsado");
        },
      )),
    );
  }
}
