import 'dart:io';

import 'package:firebase/addPost/data/AddPostRepo.dart';
import 'package:firebase/addPost/presentation/cubit/AddPostsStates.dart';
import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostsCubit extends Cubit<AddPostsStates> {
  AddPostRepo repo;
  AddPostsCubit(this.repo) : super(AddPostsInitialState());
  static AddPostsCubit get(context) => BlocProvider.of(context);

  File? imageFile;
  Future<void> getImage() async {
    imageFile = await repo.getImage();
    emit(GetImageState());
  }

  Future<void> uploadPost(UserModel userModel, File? imagePath, String text,
      String dateTime) async {
    try {
      await repo.createPost(userModel, imagePath, text, dateTime);
      emit(PostCreatedSuccessState());
    } catch (erorr) {
      print('Error');
    }
  }
}
