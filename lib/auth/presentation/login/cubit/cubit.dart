import 'package:firebase/auth/data/AuthRepo.dart';
import 'package:firebase/auth/presentation/login/cubit/states.dart';
import 'package:firebase/model/social_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  Authrepo repo;
  SocialLoginCubit(this.repo) : super(SocialInitialLoginState());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);

  
  SocialModel ?model;
  void loginHandler(String email,String password)async{
    model = await repo.loginUser(email, password);
    emit(SocialSuccessLoginState());

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