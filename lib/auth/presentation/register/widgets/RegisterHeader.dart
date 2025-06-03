import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        Text(
          'Register now to get connect',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
