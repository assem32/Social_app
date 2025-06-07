import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/chat/data/model/message_model.dart';
import 'package:firebase/chat/data/remote/ChatRemote.dart';

class ChatRepo {
  ChatRemote remote;
  ChatRepo(this.remote);

  Future<List<UserModel>> getUsers()async{
    return await remote.getUserDataChat();
  }

  Stream<List<MessageModel>> getMessagesStream(String? reciverId) {
    return  remote.getMessageStream(reciverId);
  }

  void sendMessage(String? reciverId,String message ) {
    remote.sendMessages(reciverId, message);
  }
}