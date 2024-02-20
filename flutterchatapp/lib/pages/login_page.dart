import 'package:flutter/material.dart';
import 'package:flutterchatapp/auth/auth_service.dart';
import 'package:flutterchatapp/components/buttoncomp.dart';
import 'package:flutterchatapp/components/textfieldcomp.dart';

class LoginPage extends StatelessWidget {
  // E and Pw Controller
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwEditingController = TextEditingController();

  // Login Method
  void login(BuildContext context) async{
    // Auth Serv
    final authService = AuthService();


    // try Login and Catch Errors
  try {
    await authService.signInWEmailPassword(_emailEditingController.text, _passwEditingController.text);
  }catch (e){
    showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString())));
  }

  }

  // go Regis
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //  Logo App
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),

          // Icon App
          const SizedBox(height: 50),

          // Welcome Message
          Text(
            " Welcome Na krub to my Chat App",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 30),
          // email Text Message
          TextFieldComp(
            hinttext: 'Email',
            obscureText: false,
            controller: _emailEditingController,
          ),

          const SizedBox(height: 30),
          // Paswww Message
          TextFieldComp(
            hinttext: 'Password',
            obscureText: true,
            controller: _passwEditingController,
          ),

          const SizedBox(height: 30),
          // Login button
          ButtonMe(
            NameButton: 'Login',
            onTap: () => login(context),
          ),

          const SizedBox(height: 15),

          // Register button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No Account?",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  " Register Now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }


}
