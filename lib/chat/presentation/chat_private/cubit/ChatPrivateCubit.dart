import 'package:firebase/chat/data/ChatRepo.dart';
import 'package:firebase/chat/data/model/message_model.dart';
import 'package:firebase/chat/presentation/chat_private/cubit/ChatPrivateState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPrivatecubit extends Cubit<ChatPrivateState> {
  ChatRepo repo;
  ChatPrivatecubit(this.repo) : super(ChatPrivateInitState());
  static ChatPrivatecubit get(context) => BlocProvider.of(context);

  void sendMessage(String reciverId, String message) {
    print ('done sent');
    repo.sendMessage(reciverId, message);
    emit(ChatPrivateSendMessageSuccess());
  }

  // List<MessageModel> messageList = [];
  // Future<void> getMessage(String? reciverId) async {
  //   messageList = (await repo.getMessages(reciverId)) as List<MessageModel>;
  //   emit(ChatPrivateGetMessageSuccess());
  // }

  Stream<List<MessageModel>> getMessagesStream(String? receiverId) {
    return repo.getMessagesStream(receiverId);
  }
}
