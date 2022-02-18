import 'package:bloc/bloc.dart';
import 'package:firebase/modules/social_app/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialInitialLoginState());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);
  void userLogin({
    required String mail,
    required String pass,}){
    emit(SocialLoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword
      (
        email: mail,
        password: pass
    ).then((value) {
      emit(SocialSuccessLoginState(value.user!.uid));
    }).catchError((error){
      emit(SocialErrorLoginState(error.toString()));
    });
  }

  IconData suffix= Icons.visibility_outlined;
  bool isPassWord=true;
  void changePasswordVisibility()
  {
    isPassWord=!isPassWord;
    suffix=isPassWord ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialSuffixState());
  }
}