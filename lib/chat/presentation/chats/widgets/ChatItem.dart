import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/chat/presentation/chat_private/ChatPrivate.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final UserModel model;
  const ChatItem(this.model,{super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPrivate(
                       model,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            SizedBox(
              width: 10,
            ),
            Text('${model.name}'),
          ],
        ),
      ),
    );
    
  }
}
