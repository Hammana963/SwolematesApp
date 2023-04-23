import 'package:flutter/material.dart';
import 'package:swolematesflutterapp/pages/login_page.dart';
import 'package:swolematesflutterapp/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {

  const LoginOrRegisterPage({Key? key,}) : super(key: key);

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //initially show login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
          onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
