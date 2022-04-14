import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var commentController = TextEditingController();

class CommentScreen extends StatelessWidget {
  String postId;
   CommentScreen(this.postId);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){

      },
      builder: (context,state){
        SocialCubit.get(context).getComments(postId);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                'https://img.freepik.com/free-vector/gradient-eid-al-fitr-greeting-card-template_52683-83420.jpg?t=st=1649958063~exp=1649958663~hmac=421c1a8d82bcb4e30a7bc5da97033aab0a9bd1aa7f8ab0f7f3dacd1b58fa66e5&w=740'
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                'assem',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'lll',
                              ),
                            )
                          ],
                        ),
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
