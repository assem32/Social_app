import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemote {
  Future<UserModel> loginUser(String email, String password) async {
    var userCred = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    var id = userCred.user?.uid;
    var userData =
        await FirebaseFirestore.instance.collection('user').doc(id).get();
    return UserModel.fromJson(userData.data());
  }

  Future<UserModel> userRegister({
    required String name,
    required String mail,
    required String pass,
    required String phone,
  }) async {
    var userCred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: pass);
    UserModel model = userCreate(
      mail: mail,
      name: name,
      phone: pass,
      uId: userCred.user!.uid,
    );

    return model;
  }

  UserModel userCreate({
    required String name,
    required String mail,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      mail: mail,
      phone: phone,
      uId: uId,
      bio: 'write your status',
      image:
          'https://image.freepik.com/free-photo/pleasant-looking-serious-man-stands-profile-has-confident-expression-wears-casual-white-t-shirt_273609-16959.jpg',
      cover:
          'https://image.freepik.com/free-photo/pour-soft-drink-glass-with-ice-splash-dark-background_79161-3.jpg',
      isMailVer: false,
    );
    FirebaseFirestore.instance.collection('user').doc(uId).set(model.toMap());
    return model;
  }
}
