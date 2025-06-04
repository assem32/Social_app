import 'dart:io';

import 'package:firebase/addPost/data/local/AddPostLocal.dart';
import 'package:firebase/addPost/data/remote/AddPostsRemote.dart';
import 'package:firebase/auth/data/model/UserModel.dart';

class AddPostRepo {
  AddPostLocal addPostLocal;
  AddPostsRemote addPostsRemote;
  AddPostRepo(this.addPostLocal, this.addPostsRemote);
  Future<File?> getImage()async{
    return await addPostLocal.getImagePost();    
  }

  Future<void> createPost(UserModel userModel , File? imagePath, String text,String dateTime)async{
    if (imagePath ==null){
      String? imagePath1;
      addPostsRemote.createPost(userModel, imagePath1, dateTime, text);
    }
    else {
      String path = await addPostsRemote.uploadImagePost(dateTime: dateTime, text: text, imagePost: imagePath);
       addPostsRemote.createPost(userModel, path, dateTime, text);
    }

  }

}