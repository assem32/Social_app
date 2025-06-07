

import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/chat/data/ChatRepo.dart';
import 'package:firebase/chat/presentation/chats/cubit/ChatState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chatcubit extends Cubit<ChatState> {
  ChatRepo repo;
  Chatcubit(this.repo) : super(ChatInitState());
  static Chatcubit get(context) => BlocProvider.of(context);

  List<UserModel>usersChat=[];
  void getUsers()async{
    usersChat=await repo.getUsers();
    print('$usersChat this is the list');
    emit(ChatUserGetSuccess());
  }
}