import 'package:firebase/component/component.dart';
import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/model/add_post.dart';
import 'package:firebase/model/comment.dart';
import 'package:firebase/modules/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var commentController = TextEditingController();

class CommentScreen extends StatelessWidget {
  String postId;

   CommentScreen(this.postId,);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){

      },
      builder: (context,state){
        SocialCubit.get(context).getComments(postId);
        List<CommentModel> model=SocialCubit.get(context).getcomment;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => InkWell(child: buildComment(model[index]),onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(model[index])));},),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: SocialCubit.get(context).getcomment.length)),
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
                      SocialCubit.get(context).createComment(commentController.text, postId);
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
