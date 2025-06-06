import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ImageHelper {

  static Future<File?> getImagePost()async{
    File ?imagePost;
    var picker=ImagePicker();
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null) {
      imagePost = File(pickedFile.path);
      print(pickedFile.path);
    } else {
      print('no image selected');
    }
    return  imagePost;
  }


  static Future<String> uploadImagePost(
      {
      required File imagePost,
      required String path
      }) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('$path/${Uri.file(imagePost.path).pathSegments.last}');

    final uploadImage = await ref.putFile(imagePost);
    return await uploadImage.ref.getDownloadURL();
  }
}