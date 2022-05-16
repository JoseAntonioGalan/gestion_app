import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_app/repository/authentication_client.dart';
import 'package:gestion_app/screens/login_page.dart';
import 'package:gestion_app/utils/validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _nameFocusNode = FocusNode();

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();

  final _authClient = AuthenticationClient();

  bool _isProgress = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
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
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  validator: Validator.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Introduce tu nombre',
                    label: Text('Nombre'),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  validator: Validator.email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Introduce tu email',
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
                _isProgress
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isProgress = true;
                              });
                              final User? user = await _authClient.registerUser(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              setState(() {
                                _isProgress = false;
                              });

                              if (user != null) {
                                Navigator.of(context).pushNamed("/login_page");
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Registrarse',
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ),
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
