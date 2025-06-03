import 'package:firebase/auth/data/AuthRepo.dart';
import 'package:firebase/auth/presentation/register/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  Authrepo repo;

  SocialRegisterCubit(this.repo) : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void registerHandler(
    String name,
    String mail,
    String pass,
    String phone,
  ) async {
    await repo.userRegister(name: name, mail: mail, pass: pass, phone: phone);
    emit(SocialRegisterSuccessState());
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassWord = true;
  void changePasswordVisibility() {
    isPassWord = !isPassWord;
    suffix =
        isPassWord ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterSuffixState());
  }
}
