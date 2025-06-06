import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/feed/data/model/PostModel.dart';

class ProfileRemote {
  Future<UserModel> getUserData(String uId) async {
    UserModel model;
    final snapshot =
        await FirebaseFirestore.instance.collection('user').doc(uId).get();
    model = UserModel.fromJson(snapshot.data());
    return model;
  }

  Future<List<PostModel>> profilePost(String? userId) async{
    List<PostModel> userData = [];
    final snap = await FirebaseFirestore.instance
        .collection('post')
        .orderBy('dateTime')
        .get();

        for (var doc in snap.docs){
          if(doc.data()['uId']==userId){
            userData.add(PostModel.fromJson(doc.data()));
          }
        }
        return userData;

  }

  Future<UserModel> updateUser(
   UserModel userModel
)async{
  UserModel? model;
    await FirebaseFirestore.instance.collection('user').doc(userModel.uId).update(userModel.toMap()).then((value)async{
      model= await getUserData(userModel.uId!);
    }).catchError((error){
      print(error.toString());
    });
    return model!;
  }
}
