import 'dart:io';
import 'package:firebase/utils/ImageHelper.dart';
import 'package:firebase/utils/StaticValues.dart';
import 'package:firebase/personalProfile/data/ProfileRepo.dart';
import 'package:firebase/personalProfile/edit_profile/cubit/States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  ProfileRepo repo;
  EditProfileCubit(this.repo) : super(EditProfileInitState());
  static EditProfileCubit get(context) => BlocProvider.of(context);

  void updateProfile(
    String name,
    String phone,
    String bio,
  ) async{
    StaticValues.userModel?.phone = phone;
    StaticValues.userModel?.bio = bio;
    StaticValues.userModel?.name = name;  

    if(coverImage!=null){
      StaticValues.userModel?.cover= await ImageHelper.uploadImagePost(imagePost: coverImage!, path: "user");
      }

      if(profileImage!=null){
      StaticValues.userModel?.image= await ImageHelper.uploadImagePost(imagePost: profileImage!, path: "user");
      }
    

    repo.updateProfile(StaticValues.userModel!);
    emit(EditDataSuccess());
  }

  File? profileImage;

  void selectProfileImage()async {
    profileImage = await repo.selectImage();
    emit(SelectImageState());
  }

  File? coverImage;

  void selectProfileCover()async {
    coverImage = await repo.selectImage();
    emit(SelectImageState());
  }

  
}
