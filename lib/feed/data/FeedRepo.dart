import 'package:firebase/feed/data/model/Commet.dart';
import 'package:firebase/feed/data/model/PostModel.dart';
import 'package:firebase/feed/data/remote/FeedRemote.dart';

class FeedRepo {
  FeedRemote feedRemote;
  FeedRepo (this.feedRemote);

  Future<List<PostModel>> getPost() async{
    return await feedRemote.getPost();
  }

  Future<List<CommentModel> >getComments(String postId) async {
    return await feedRemote.getComments(postId);
  }

  void createComment(String text,String postId){
    feedRemote.createComment(text, postId);
  }
  

}