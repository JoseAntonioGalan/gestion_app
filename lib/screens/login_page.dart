import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_app/estados/login_state.dart';
import 'package:gestion_app/repository/authentication_client.dart';
import 'package:gestion_app/utils/validator.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();

  final _authClient = AuthenticationClient();

  bool _isProgressEmail = false;

  bool _isProgressGoogle = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  validator: Validator.email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Introduce tu Email',
                    label: Text('Email'),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  validator: Validator.password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Introduce tu contraseña',
                    label: Text('Contraseña'),
                  ),
                ),
                const SizedBox(height: 24),
                _isProgressEmail
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isProgressEmail = true;
                              });
                              final User? user = await _authClient.loginUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              setState(() {
                                _isProgressEmail = false;
                              });
                              if (user != null) {
                                var login = Provider.of<LoginState>(context,
                                    listen: false);
                                login.login();
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 24),
                _isProgressGoogle
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isProgressGoogle = true;
                            });
                            final User? user =
                                await _authClient.loginWithGoogle(context);
                            setState(() {
                              _isProgressGoogle = false;
                            });
                            if (user != null) {
                              var login = Provider.of<LoginState>(context,
                                  listen: false);
                              login.login();
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Iniciar Sesión con Google',
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/register_page");
                  },
                  child: const Text(
                    'No tienes cuenta? Pulsa aquí para registrarte',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
