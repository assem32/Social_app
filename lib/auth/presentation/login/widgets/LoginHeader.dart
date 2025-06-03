import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        const Text('Login',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        Text('Connect with your friends',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
