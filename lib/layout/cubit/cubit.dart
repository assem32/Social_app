import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/feed/data/model/Commet.dart';
import 'package:firebase/addPost/presentation/AddPost.dart';
import 'package:firebase/feed/presentation/feed_screen.dart';
import 'package:firebase/modules/search_screen/search.dart';
import 'package:firebase/personalProfile/personalProfilePresentation/PersonalProfile.dart';
import 'package:firebase/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialize());
  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  void getUserData() {
    emit(SocialLoading());
    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      print(value.data());
      model = UserModel.fromJson(value.data());
      emit(SocialSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SocialError(error));
    });
  }

  int currentIndex = 0;
  List<Widget> screen = [
    FeedScreen(),
    SearchScreen(),
    AddPost(),
    SettingsScreen(),
  ];
  List<String> title = [
    'Home',
    'Search',
    'add',
    'Profile',
  ];
  void changeNav(int index) {
    
      currentIndex = index;
      print(index);
      emit(SocialNav());
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'likes': true}).then((value) {
      emit(SocialLikePostSuccess());
    }).catchError((error) {
      emit(SocialLikePostError(error.toString()));
    });
  }


  void createComment(String text, String postId) {
    CommentModel cModel = CommentModel(
      name: model?.name,
      uId: model?.uId,
      image: model?.image,
      bio: model?.bio,
      //dateTime: dateTime,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('comments')
        .add(cModel.toMap())
        .then((value) {
      emit(CreateCommentSuccessState());
    }).catchError((error) {
      emit(CreateCommentErrorState());
    });
  }

  List<UserModel> SearchUser = [];
  void searchUser(String name) {
    FirebaseFirestore.instance.collection('user').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['name'] == name)
          SearchUser.add(UserModel.fromJson(element.data()));
        emit(GetSearchSuccessState());
      });
    }).catchError((error) {});
  }
}
