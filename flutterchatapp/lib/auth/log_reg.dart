import 'package:flutter/material.dart';
import 'package:flutterchatapp/pages/login_page.dart';
import 'package:flutterchatapp/pages/regis_page.dart';

class LogOrReg extends StatefulWidget {
  const LogOrReg({super.key});

  @override
  State<LogOrReg> createState() => _LogOrRegState();
}

class _LogOrRegState extends State<LogOrReg> {
  // First Time See Login
  bool showLogin = true;

  // toggle between login and Register
  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisPage(
        onTap: togglePages,
      );
    }
  }
}
