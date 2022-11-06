import 'dart:io';

import 'package:flutter/material.dart';
import 'package:overwatched/pages/register.dart';

import '../models/login_request.dart';
import '../models/login_response.dart';
import '../stores/user_store.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _onClickLogin(BuildContext context) async {
    UserStore userStore = UserStore();
    LoginRequest user = LoginRequest(username: usernameController.text, password: passwordController.text);

    try {
      LoginResponse res = await userStore.login(user);
      _login(context);
    } catch (err) {
      print(err);
      String message = 'Um erro ocorreu ao fazer o login. Tente novamente.';
      if (err is HttpException) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message))
      );
    }
  }

  void _login(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  void _onClickRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Overwatched'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text("Login",
                        style: Theme.of(context).textTheme.headline3)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => _onClickRegister(context),
                            child: const Text("Criar conta")),
                        OutlinedButton(
                            onPressed: () => _onClickLogin(context),
                            child: const Text('Entrar')),
                      ],
                    ))
              ],
            )));
  }
}
