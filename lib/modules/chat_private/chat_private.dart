import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/model/message_model.dart';
import 'package:firebase/model/social_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
TextEditingController messageController=TextEditingController();

class ChatPrivate extends StatelessWidget {
  SocialModel ?umodel;

  ChatPrivate({this.umodel});

  @override
  Widget build(BuildContext context) {
    return  Builder(
      builder: (BuildContext context){
        SocialCubit.get(context).getMessages(receiverId: umodel!.uId);
        //print(umodel?.uId);
       // print(SocialCubit.get(context).model?.uId);


        //print(SocialCubit.get(context).message);
        return BlocConsumer<SocialCubit,SocialState>(
          listener: (context, state){},
          builder: (context, state){
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                    leading: IconButton(
                      icon: Icon(
                          IconBroken.Arrow___Left_2),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              '${umodel!.image}'
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                            '${umodel!.name}'
                        ),
                      ],
                    )

                ),
                body: ConditionalBuilder(
                  condition: SocialCubit.get(context).message.length>=0,
                  builder: (context)=>Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                                itemBuilder: (context,index){
                                  var message=SocialCubit.get(context).message[index];
                                  //print('sender${message.senderId}');
                                  //print('receiver${message.receiverId}');
                                  //print(SocialCubit.get(context).model?.uId);
                                  if(SocialCubit.get(context).model?.uId==message.receiverId) {
                                  return buildChatMessage(message);
                                }else
                                    return buildChatMessageReceiver(message);
                                },
                                separatorBuilder: (context,index)=>SizedBox(
                                  height: 15,
                                ),
                                itemCount: SocialCubit.get(context).message.length)
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10
                                  ),
                                  child: TextField(
                                    //keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Massege.....'
                                    ),
                                    controller: messageController,
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                color: Colors.blue,
                                child: MaterialButton(onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: umodel?.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text
                                  );
                                  messageController.clear();
                                },
                                  minWidth: 1.0,
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  fallback: (context)=>Center(child: CircularProgressIndicator()),
                )

            );
          },
        );
      }

    );
  }
  Widget buildChatMessage(Message mModel )=>Align(
    alignment: AlignmentDirectional.centerStart,

    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Text(
          '${mModel.text}'
      ),

    ),
  );
  Widget buildChatMessageReceiver(Message mModel)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(.3),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Text(
          '${mModel.text}'
      ),
    ),
  );
}
