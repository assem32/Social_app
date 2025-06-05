import 'package:firebase/component/component.dart';
import 'package:firebase/feed/presentation/cubit/FeedCubit.dart';
import 'package:firebase/feed/presentation/cubit/FeedStates.dart';
import 'package:firebase/personalProfile/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var commentController = TextEditingController();

class CommentScreen extends StatelessWidget {
  final String postId;
  const CommentScreen(this.postId, {super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<FeedCubit,FeedState>(
      listener: (context,state){

      },
      builder: (context,state){
        FeedCubit.get(context).getComments(postId);
        
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => InkWell(child: buildComment(FeedCubit.get(context).comment[index]),onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(FeedCubit.get(context).comment[index].uId)));},),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: FeedCubit.get(context).comment.length)),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                            hintText: 'Write a comment....',
                            border: InputBorder.none
                        ),

                      ),
                    ),
                    TextButton(onPressed: () {
                      FeedCubit.get(context).createComment(commentController.text, postId);
                      commentController.clear();
                    }, child: Text('Post'))
                  ],
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
