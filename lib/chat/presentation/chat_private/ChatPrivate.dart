import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/chat/data/ChatRepo.dart';
import 'package:firebase/chat/data/remote/ChatRemote.dart';
import 'package:firebase/chat/presentation/chat_private/cubit/ChatPrivateCubit.dart';
import 'package:firebase/chat/presentation/chat_private/cubit/ChatPrivateState.dart';
import 'package:firebase/chat/presentation/chat_private/widgets/ChatTextField.dart';
import 'package:firebase/chat/presentation/chat_private/widgets/MessageItem.dart';
import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/chat/data/model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

TextEditingController messageController = TextEditingController();

class ChatPrivate extends StatelessWidget {
  final UserModel umodel;

  const ChatPrivate(this.umodel, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatPrivatecubit(ChatRepo(ChatRemote())),
      child: BlocConsumer<ChatPrivatecubit, ChatPrivateState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              leading: IconButton(
                icon: const Icon(IconBroken.Arrow___Left_2),
                onPressed: () => Navigator.pop(context),
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${umodel.image}'),
                  ),
                  const SizedBox(width: 10),
                  Text('${umodel.name}'),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<MessageModel>>(
                    stream: ChatPrivatecubit.get(context)
                        .getMessagesStream(umodel.uId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text("Error loading messages"));
                      }

                      final messages = snapshot.data ?? [];

                      return ListView.separated(
                        padding: const EdgeInsets.all(10),
                        physics: const BouncingScrollPhysics(),
                        itemCount: messages.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isSender = message.senderId ==
                              FirebaseAuth.instance.currentUser!.uid;

                          return Align(
                            alignment: isSender
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: MessageItem(
                              model: message,
                              color: isSender ? 0xffeafcca : 0xfff0f9fb,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                ChattextFormField(messageController, () {
                  if (messageController.text.trim().isNotEmpty) {
                    ChatPrivatecubit.get(context).sendMessage(
                      umodel.uId!,
                      messageController.text.trim(),
                    );
                    messageController.clear();
                  }
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
