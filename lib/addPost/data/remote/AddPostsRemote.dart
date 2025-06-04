import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/feed/data/model/PostModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddPostsRemote {


  Future<String> uploadImagePost(
      {required String dateTime,
      required String text,
      required File imagePost}) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('path/${Uri.file(imagePost.path).pathSegments.last}');

    final uploadImage = await ref.putFile(imagePost);
    return await uploadImage.ref.getDownloadURL();
  }

  void createPost(
      UserModel userModel,String? imagePost, String dateTime, String text) {
        final docRef = FirebaseFirestore.instance.collection('post').doc();
    PostModel cModel = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
      bio: userModel.bio,
      imagePost: imagePost ?? '',
      dateTime: dateTime,
      text: text,
      commentNum: 0,
      likesNum: 0,
      postId: docRef.id
    );
    docRef.set(cModel.toMap());
    
}
}