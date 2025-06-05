import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/feed/data/model/PostModel.dart';
import 'package:firebase/personalProfile/data/remote/ProfileRemote.dart';

class ProfileRepo {
  ProfileRemote remote;
  ProfileRepo(this.remote);

  Future<UserModel> getUserData(String uId) async {
    return await remote.getUserData(uId);
  }

  Future<List<PostModel>> getPostUser(String uId) {
    return remote.profilePost(uId);
  }
}
