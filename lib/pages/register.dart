import 'dart:io';

import 'package:flutter/material.dart';
import 'package:overwatched/models/login_request.dart';

import '../stores/user_store.dart';
import 'home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _onClickCreate(BuildContext context) async {
    UserStore userStore = UserStore();
    LoginRequest user = LoginRequest(username: usernameController.text, password: passwordController.text);

    try {
      await userStore.create(user);
      _doAutoLogin(context, user);
    } catch (err) {
      print(err);
      String message = 'Um erro ocorreu ao criar a conta. Tente novamente.';
      if (err is HttpException) {
        message = err.message;
      }
      showSnackbar(context, message);
    }
  }

  void _doAutoLogin(BuildContext context, LoginRequest user) async {
    UserStore userStore = UserStore();

    try {
      await userStore.login(user);
      _login(context);
    } catch (err) {
      print(err);
      String message = 'Um erro ocorreu ao fazer o login. Tente novamente.';
      if (err is HttpException) {
        message = err.message;
      }
      showSnackbar(context, message);

      await Future.delayed(const Duration(seconds: 1));
      _goToLoginPage(context);
    }
  }

  void _login(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  void _goToLoginPage(BuildContext context) {
    Navigator.of(context).pop();
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text))
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
                    child: Text("Criar conta",
                        style: Theme.of(context).textTheme.headline3)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    controller: usernameController
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    controller: passwordController,
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
                            onPressed: () => _goToLoginPage(context),
                            child: const Text("Já possui conta?")),
                        OutlinedButton(
                            onPressed: () => _onClickCreate(context),
                            child: const Text('Criar')),
                      ],
                    ))
              ],
            )));
  }
}
