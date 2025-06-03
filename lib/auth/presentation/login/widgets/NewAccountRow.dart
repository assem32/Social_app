import 'package:firebase/auth/presentation/register/social_register.dart';
import 'package:flutter/material.dart';

class NewAccountRow extends StatelessWidget {
  const NewAccountRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          child: const Text('Register'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SocialRegister()),
            );
          },
        )
      ],
    );
  }
}
