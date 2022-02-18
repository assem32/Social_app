
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/model/social_model.dart';
import 'package:firebase/modules/chat_private/chat_private.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
        listener:(context, state) {
        } ,
        builder: (context,state){
          return ConditionalBuilder(
            condition: SocialCubit.get(context).users.length>0,
            builder:(context)=> Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
                  separatorBuilder: (context,index)=>Container(
                height: 1,
                color: Colors.grey,

              ), itemCount: SocialCubit.get(context).users.length
             ),
            ),
            fallback:(context)=> Center(
              child: Text(
                  'No other users',
                style: TextStyle(fontWeight: FontWeight.bold,),
              ),
            ),
          );
        });

  }
  Widget buildChatItem(SocialModel model,context)=>InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPrivate(umodel: model, )));
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                '${model.image}'
            ),
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