import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/feed/data/model/Commet.dart';
import 'package:firebase/feed/data/model/PostModel.dart';

class FeedRemote {
  Future<List<PostModel>> getPost() async {
    var snapshots = await FirebaseFirestore.instance.collection('post').get();
    List<Future<PostModel>> futures = snapshots.docs.map((doc) async {
      final data = doc.data();

      final commentsFuture = doc.reference.collection('comments').get();
      final likesFuture = doc.reference.collection('likes').get();

      final commentsSnapshot = await commentsFuture;
      final likesSnapshot = await likesFuture;

      final model = PostModel.fromJson(data);
      model.commentNum = commentsSnapshot.docs.length;
      model.likesNum = likesSnapshot.docs.length;

      return model;
    }).toList();

    return Future.wait(futures);
  }

  Future<List<CommentModel>> getComments(String postId) async {
    List<CommentModel> getcomment = [];
    final snapshot = await FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('comments')
        .get();
    for (var doc in snapshot.docs) {
      getcomment.add(CommentModel.fromJson(doc.data()));
    }
    return getcomment;
  }

  void createComment(
    String text,
    String postId,
  )async {
    CommentModel cModel = CommentModel(
      name: 'assem a',
      uId: 'oeveka1sXOgBIN3F5BRobck7yDF3',
      image:
          "https://firebasestorage.googleapis.com/v0/b/assemprroject.appspot.com/o/user%2Fimage_picker595847841072782088.jpg?alt=media&token=320a9c62-95b4-45af-b5fd-6802761e1cc6",
      bio: "hello there",
      //dateTime: dateTime,
      text: text,
    );
    await FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('comments')
        .add(cModel.toMap())
        .then((value) {
      print("done");
    }).catchError((error) {
      print("wrong");
    });
  }

  void likePost() {}
}
