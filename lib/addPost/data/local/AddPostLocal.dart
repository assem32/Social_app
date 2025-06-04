import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AddPostLocal {
  

  
  Future<File?> getImagePost()async{
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
}