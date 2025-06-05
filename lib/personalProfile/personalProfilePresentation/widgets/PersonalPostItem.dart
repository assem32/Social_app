import 'package:flutter/material.dart';

class PersonalPostItem extends StatelessWidget {
  final String image;
  const PersonalPostItem(this.image,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        fit: BoxFit.cover,
        image: NetworkImage(
          image
      ),
    ));;
  }
}