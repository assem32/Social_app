import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/social_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemote{
  Future<SocialModel> loginUser(String email,String password)async {
   var userCred = await FirebaseAuth.instance.signInWithEmailAndPassword
      (
        email: email,
        password: password
    );
   var id = userCred.user?.uid;
   var userData= await FirebaseFirestore.instance.collection('user').doc(id).get();
   return SocialModel.fromJson(userData.data());
  }





}