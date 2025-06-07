
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/chat/data/ChatRepo.dart';
import 'package:firebase/chat/data/remote/ChatRemote.dart';
import 'package:firebase/chat/presentation/chats/cubit/ChatCubit.dart';
import 'package:firebase/chat/presentation/chats/cubit/ChatState.dart';
import 'package:firebase/chat/presentation/chats/widgets/ChatItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> Chatcubit(ChatRepo(ChatRemote()))..getUsers(),
      child: BlocConsumer<Chatcubit,ChatState>(
          listener:(context, state) {
          } ,
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
      
              ),
              body: ConditionalBuilder(
                condition: Chatcubit.get(context).usersChat.length>0,
                builder:(context)=> Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>ChatItem(Chatcubit.get(context).usersChat[index]),
                      separatorBuilder: (context,index)=>Container(
                    height: 1,
                    color: Colors.grey,
      
                  ), itemCount: Chatcubit.get(context).usersChat.length
                 ),
                ),
                fallback:(context)=> Center(
                  child: Text(
                      'No other users',
                    style: TextStyle(fontWeight: FontWeight.bold,),
                  ),
                ),
              ),
            );
          }),
    );

  }
}