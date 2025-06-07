import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/chat/data/model/message_model.dart';
import 'package:firebase/utils/StaticValues.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRemote {
  Future<List<UserModel>> getUserDataChat() async {
    List<UserModel> usersList = [];
    final snapshot = await FirebaseFirestore.instance.collection('user').get();
    for (var doc in snapshot.docs) {
      if (doc.id != StaticValues.userModel?.uId) {
        usersList.add(UserModel.fromJson(doc.data()));
      }
    }
    return usersList;
  }

  DatabaseReference ref1 = FirebaseDatabase.instance.ref();
  void sendMessages(String? reciverId, String message) {
    ref1
        .child('Messages')
        .child(FirebaseAuth.instance.currentUser!.uid.toString() + reciverId!)
        .push()
        .set(
          MessageModel(
            dateTime: DateTime.now().toIso8601String(),
            message: message,
            senderId: FirebaseAuth.instance.currentUser!.uid.toString(),
          ).toMap(),
        )
        .then((d) {})
        .catchError((e) {
      print(e.toString());
    });
  }

  Stream<List<MessageModel>> getMessageStream(String? receiverId) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final path1 = '$currentUserId$receiverId';
    final path2 = '$receiverId$currentUserId';

    final controller = StreamController<List<MessageModel>>();
    final List<MessageModel> messages = [];

    ref1.child('Messages').child(path1).onChildAdded.listen((event) {
      print('messages');
      print(event.snapshot.value);
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        messages.add(MessageModel.fromJson(data));
        controller.add(List.from(messages));
      }
    });

    ref1.child('Messages').child(path2).onChildAdded.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        messages.add(MessageModel.fromJson(data));
        controller.add(List.from(messages));
      }
    });

    return controller.stream;
  }
}
