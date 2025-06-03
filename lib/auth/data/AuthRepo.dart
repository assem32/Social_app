import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/data/remote/AuthRemote.dart';
import 'package:firebase/model/social_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authrepo {
  AuthRemote authRemote;
  Authrepo(this.authRemote);

  Future <SocialModel> loginUser(String email,String password)async{
    print('done login');
    return await authRemote.loginUser(email, password);
  }


  Future<SocialModel> userRegister({
  required String name,
  required String mail,
  required String pass,
  required String phone,
  })async
  {
   var userCred= await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail, password: pass
    );
    SocialModel model = userCreate(
      mail: mail,
      name: name,
      phone: pass,
      uId: userCred.user!.uid,
    );

    return model;
  }
  SocialModel userCreate({
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
        .doc(uId).set(model.toMap());
        return model;
}

}