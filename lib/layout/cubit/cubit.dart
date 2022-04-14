import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/model/add_post.dart';
import 'package:firebase/model/comment.dart';
import 'package:firebase/model/message_model.dart';
import 'package:firebase/model/social_model.dart';
import 'package:firebase/modules/add_post/add_post.dart';
import 'package:firebase/modules/chats/chat_screen.dart';
import 'package:firebase/modules/feeds/feed_screen.dart';
import 'package:firebase/modules/settings/setting_screen.dart';
import 'package:firebase/modules/users/user_screen.dart';
import 'package:firebase/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

class SocialCubit extends Cubit<SocialState>{
  SocialCubit():super (SocialInitialize());
  static SocialCubit get(context)=> BlocProvider.of(context);
  SocialModel ?model;
  void getUserData(){
    emit(SocialLoading());
    FirebaseFirestore.instance.collection('user')
        .doc(uId)
        .get()
        .then((value ){
          print(value.data());
          model= SocialModel.fromJson(value.data());
          emit(SocialSuccess());
    } ).catchError((error){
      print(error.toString());
      emit(SocialError(error));
    });
  }

  int currentIndex=0;
  List<Widget> screen=[
    FeedScreen(),
    ChatScreen(),
    AddPost(),
    UserScreen(),
    SettingsScreen(),
  ];
  List<String> title=[
    'Home',
    'Chat',
    'add',
    'User',
    'Settings',
  ];
  void changeNav(int index){
    if(index==1)
      getUserDataChat();
    if(index==2)
      emit(SocialAddPost());
    else {
      currentIndex = index;
      print(index);
      emit(SocialNav());
    }
  }

   File ?profileImage;
   File ?profileCover;
   String profileValue='';
   String coverValue='';
  var picker=ImagePicker();
  Future<void> getImage()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickSuccessPost());
    } else {
      print('no image selected');
      emit(SocialProfileImagePickErrorState());
    }
  }

  Future<void> getCover()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null) {
      profileCover = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileCoverPickSuccessState());
    } else {
      print('no image selected');
      emit(SocialProfileCoverPickErrorState());
    }
  }
  
  void uploadImage({
    required String bio,
    required String name,
    required String phone
}) {
    emit(SocialUpdateLoadingUserState());
    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child('user/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(bio: bio, name: name, phone: phone,profile: value);
       // emit(SocialProfileUploadSuccessState());
      }).catchError((error) {
        print(error);
        emit(SocialProfileUploadErrorState());
      });
    })
        .catchError((error) {
      print(error);
      emit(SocialProfileUploadErrorState());
    });


  }

  void uploadCover({
    required String bio,
    required String name,
    required String phone,
  }) {
    emit(SocialUpdateLoadingUserState());
    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child('user/${Uri
        .file(profileCover!.path)
        .pathSegments
        .last}')
        .putFile(profileCover!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          bio: bio,
          name: name,
          phone: phone,
          cover: value
        );
        emit(SocialProfileCoverUploadSuccessState());
      }).catchError((error) {
        print(error);
        emit(SocialProfileCoverUploadErrorState());
      });
    })
        .catchError((error) {
      print(error);
      emit(SocialProfileCoverUploadErrorState());
    });
  }

  // void updateUserImage({
  //   required String name,
  //   required String bio,
  //   required String phone,
  // }){
  //   emit(SocialUpdateSuccessUserState());
  //
  //   if(profileCover!=null)
  //     uploadCover();
  //   else if(profileImage!=null)
  //     uploadImage();
  //   else
  //   {
  //     updateUser(bio: bio, name: name, phone: phone);
  //   }
  //
  // }


  void updateUser({
  required String bio,
  required String name,
  required String phone,
    String ?cover,
    String ?profile,
}){
    SocialModel umodel =SocialModel(
        name: name,
        phone: phone,
        bio: bio,
        cover: cover??model?.cover,
        image: profile??model?.image,
        mail: model?.mail,
        uId: model?.uId,
        isMailVer: false


    );

    FirebaseFirestore.instance.collection('user').doc(model?.uId).update(umodel.toMap()).then((value){
      getUserData();
    }).catchError((error){
      print(error.toString());
    });
  }

  File ?imagePost;
  Future<void> getImagePost()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null) {
      imagePost = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialImagePostPickSuccessState());
    } else {
      print('no image selected');
      emit(SocialImagePostPickErrorState());
    }
  }
  void uploadImagePost({
  required String dateTime,
  required String text,
}){
    firebase_storage.FirebaseStorage.instance.ref().child('path/${Uri.file(imagePost!.path).pathSegments.last}').putFile(imagePost!)
        .then((value){
          value.ref.getDownloadURL().then((value){
            createPost(dateTime: dateTime, text: text,imagePost: value);
          }).catchError((error){});
          emit(SocialCreatePostErrorState());
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
}
  void removePhoto(){
    imagePost=null;
    emit(SocialRemovePostPhotoState());
  }


  void createPost({
    required String dateTime,
    required String text,
    String ?imagePost
}){
    emit(SocialCreatePostLoadingState());
    PostModel cModel=PostModel(
      name: model?.name,
      uId: model?.uId,
      image: model?.image,
      bio: model?.bio,
      imagePost: imagePost??'',
      dateTime: dateTime,
      text: text,

    );
    FirebaseFirestore.instance.collection('post').add(cModel.toMap())
        .then((value){
          emit(SocialCreatePostSuccessState());
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel>post=[];
  List<String>postId=[];
  List<int>likes=[];
  List<int>comments=[];

  void getPost(){
    FirebaseFirestore.instance.collection('post').get().then((value){


      // value.docs.forEach((element) {
      //   element.reference.collection('comments').get().then((value){
      //     comments.add(element.id);
      //   }).catchError(onError);
      // });
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value){
          comments.add(value.docs.length);
        });
        element.reference.collection('likes').get().then((value){
          likes.add(value.docs.length);
        postId.add(element.id);//to get post id
        post.add(PostModel.fromJson(element.data()));
          emit(GetUserPostSuccessState());
        }).catchError((error){
        });
      });
      emit(GetUserPostSuccessState());
    }).catchError((error){
      emit(GetUserPostErrorState(error.toString()));
      print(error.toString());
    });
  }

  void likePost(String postId){
    FirebaseFirestore
        .instance
        .collection('post')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId).set({'likes': true})
    .then((value){
      emit(SocialLikePostSuccess());
    }).catchError((error){
     emit(SocialLikePostError(error.toString()));
    }
    );
  }

  // void commentPost(String postId){
  //   FirebaseFirestore.instance.collection('post').doc(postId).collection('comments').doc(model!.uId).set(
  //       {'comment': true}).then((value) {
  //         emit(SocialCommentPostSuccess());
  //   }).catchError((error){
  //     emit(SocialCommentPostError(error.toString()));
  //   });
  // }

//users chat
  List<SocialModel> users=[];
  void getUserDataChat(){
    emit(GetUsersChatLoadingState());
    if(users.length==0)
     FirebaseFirestore.instance.collection('user')
        .get()
        .then((value ){
      value.docs.forEach((element) {
        if(element.data()['uId']!=model!.uId)
          users.add(SocialModel.fromJson(element.data()));
      });
      emit(GetUsersChatSuccessState());
    } ).catchError((error){
      print(error.toString());
      emit(GetUsersChatErrorState(error));
    });
  }

  //message
  void sendMessage({
    required receiverId,
    required dateTime,
    required text
  }){
    Message mModel= Message(
        senderId: model?.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text:text
    );
    //sender screen when send
    FirebaseFirestore.instance.collection('user')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(mModel.toMap()).then((value){
      emit(SendMassageSuccessState());
    }).catchError((error){
      emit(SendMassageErrorState());
    });

//receiver screen when send
    FirebaseFirestore.instance.collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(model?.uId)
        .collection('message')
        .add(mModel.toMap()).then((value){
      emit(SendMassageSuccessState());
    }).catchError((error){
      emit(SendMassageErrorState());
    });
  }

  List<Message> message=[];
  void getMessages({
    required String ?receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(model?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      message = [];

      event.docs.forEach((element) {
        message.add(Message.fromJson(element.data()));
      });

      emit(GetMassageSuccessState());
        });
  }
  void createComment(String text,String postId){
    CommentModel cModel=CommentModel(
        name: model?.name,
        uId: model?.uId,
        image: model?.image,
        bio: model?.bio,
        //dateTime: dateTime,
        text: text,
    );
    FirebaseFirestore.instance
    .collection('post').doc(postId).collection('comments').add(cModel.toMap()).then((value) {
      emit(CreateCommentSuccessState());
    }).catchError((error){
      emit(CreateCommentErrorState());
    });

    }

    List<CommentModel> getcomment=[];
    void getComments(String postId){
      FirebaseFirestore.instance
          .collection('post')
          .doc(postId)
          .collection('comments')
          .snapshots()
          .listen((event) {
         getcomment = [];

        event.docs.forEach((element) {
          getcomment.add(CommentModel.fromJson(element.data()));
        });

        emit(GetCommentSuccessState());
      });
    }
}