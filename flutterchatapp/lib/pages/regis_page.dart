import 'package:flutter/material.dart';
import 'package:flutterchatapp/auth/auth_service.dart';
import 'package:flutterchatapp/components/buttoncomp.dart';
import 'package:flutterchatapp/components/textfieldcomp.dart';

class RegisPage extends StatelessWidget {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwEditingController = TextEditingController();
  final TextEditingController _confirmpasswEditingController =
      TextEditingController();

// Regis Methods
  void regis(BuildContext context) {
    // Get Auth from auth_service
    final _auth = AuthService();

    if (_passwEditingController.text == _confirmpasswEditingController.text) {
      try {
        _auth.signUpWEmailPassword(
            _emailEditingController.text, _passwEditingController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(e.toString())));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) =>
            const  AlertDialog(title: Text("Password Don't Match")));
    }
  }

  // go Regis
  final void Function()? onTap;

  RegisPage({super.key, required this.onTap});

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
            " Create Account",
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

          TextFieldComp(
            hinttext: 'Confirm Password',
            obscureText: true,
            controller: _confirmpasswEditingController,
          ),

          const SizedBox(height: 30),
          // Login button
          ButtonMe(
            NameButton: 'Register',
            onTap: () => regis(context),
          ),

          const SizedBox(height: 15),

          // Register button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Have Account?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  " Login Now",
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
