import 'package:flutter/material.dart';

class ButtonMe extends StatelessWidget {

  final void Function()? onTap;

  final String NameButton;
  const ButtonMe({super.key, required this.NameButton, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Center(child: Text(NameButton)),
    ),
    );
  }
}
