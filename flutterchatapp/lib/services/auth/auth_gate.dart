
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutterchatapp/services/auth/log_reg.dart';
import 'package:flutterchatapp/pages/home_page.dart';
// import 'package:flutterchatapp/pages/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
        // User Login
        if(snapshot.hasData){
          return HomePage();
        }
        // NoT Login
        else{
          return const LogOrReg();
        }
        },
      ),
    );
  }
}