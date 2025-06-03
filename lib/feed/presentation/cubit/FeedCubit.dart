import 'package:firebase/feed/data/FeedRepo.dart';
import 'package:firebase/feed/data/model/Commet.dart';
import 'package:firebase/feed/data/model/PostModel.dart';
import 'package:firebase/feed/presentation/cubit/FeedStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedRepo repo;
  FeedCubit(this.repo) : super(FeedInitState());
  static FeedCubit get(context) => BlocProvider.of(context);

  List<PostModel> post=[];

  List<CommentModel> comment=[];

  void getPost()async{
    post =  await repo.getPost();
    emit(FeedGetPostsSuccess());
  }

  void getComments(String postId) async{
    comment = await repo.getComments(postId);
    emit(FeedGetCommentssSuccess());
  }

  void createComment(String text,String postId){
    repo.createComment(text, postId);
    getComments(postId);
  }



}
