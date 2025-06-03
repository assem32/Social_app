import 'package:firebase/auth/data/remote/AuthRemote.dart';
import 'package:firebase/auth/data/model/UserModel.dart';

class Authrepo {
  AuthRemote authRemote;
  Authrepo(this.authRemote);

  Future<UserModel> loginUser(String email, String password) async {
    return await authRemote.loginUser(email, password);
  }

  Future<UserModel> userRegister({
    required String name,
    required String mail,
    required String pass,
    required String phone,
  }) {
    return authRemote.userRegister(
        name: name, mail: mail, pass: pass, phone: phone);
  }
}
