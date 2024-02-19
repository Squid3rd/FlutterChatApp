import 'package:flutter/material.dart';
import 'package:flutterchatapp/auth/log_reg.dart';
import 'package:flutterchatapp/themes/light_made.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LogOrReg(),
      theme: lightMode,
    );
  }
}