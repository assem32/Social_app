import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/auth/data/remote/AuthRemote.dart';
import 'package:firebase/utils/StaticValues.dart';
import 'package:firebase/feed/data/model/PostModel.dart';
import 'package:firebase/personalProfile/data/ProfileRepo.dart';
import 'package:firebase/personalProfile/personalProfilePresentation/cubit/PersonalProfileState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalProfileCubit extends Cubit<PersonalProfileState> {
  ProfileRepo repo;
  PersonalProfileCubit(this.repo) : super(PersonalProfileInitState());
  static PersonalProfileCubit get(context) => BlocProvider.of(context);


 
  void getProfileData()async{
    StaticValues.userModel = await repo.getUserData(id);
    emit(PersonalDataGetSuccess());
  }

  List<PostModel> postsList=[];
  void getProfilePosts()async{
    postsList=await repo.getPostUser(id);
    emit(PersonalPostsGetSuccess());
  }
  
  
  }