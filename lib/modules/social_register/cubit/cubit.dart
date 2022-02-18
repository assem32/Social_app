import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/social_model.dart';
import 'package:firebase/modules/social_app/cubit/states.dart';
import 'package:firebase/modules/social_register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);
  void userRegister({
  required String name,
  required String mail,
  required String pass,
  required String phone,
  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail, password: pass
    ).then((value){
      userCreate(name: name, mail: mail, phone: phone, uId: value.user!.uid);

      SocialRegisterSuccessState();
    }).catchError((error)
    {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }
  void userCreate({
    required String name,
    required String mail,
    required String phone,
    required String uId,
    
}){
    SocialModel model =SocialModel(
        name: name,
      mail: mail,
      phone: phone,
      uId: uId,
      bio: 'write your status',
      image: 'https://image.freepik.com/free-photo/pleasant-looking-serious-man-stands-profile-has-confident-expression-wears-casual-white-t-shirt_273609-16959.jpg',
      cover: 'https://image.freepik.com/free-photo/pour-soft-drink-glass-with-ice-splash-dark-background_79161-3.jpg',
      isMailVer:false,
    );
    FirebaseFirestore
        .instance
        .collection('user')
        .doc(uId
    ).set(model.toMap())
        .then((value){
          emit(SocialCreateUserSuccessState());
    }).catchError((error){emit(SocialCreateUserErrorState(error));});
}

  IconData suffix= Icons.visibility_outlined;
  bool isPassWord=true;
  void changePasswordVisibility()
  {
    isPassWord=!isPassWord;
    suffix=isPassWord ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterSuffixState());
  }
}