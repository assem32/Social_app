import 'package:firebase/component/component.dart';
import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPost extends StatelessWidget {
  // const AddPost({Key? key}) : super(key: key);
  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed:(){
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2),
              ),
              title: Text('Create Post'),
              actions: [
                TextButton(onPressed: (){
                  var now=DateTime.now();

                  if(SocialCubit.get(context).imagePost==null)
                    SocialCubit.get(context).createPost(dateTime: now.toString(), text: textController.text);
                  else
                    SocialCubit.get(context).uploadImagePost(dateTime: now.toString(), text: textController.text);
                }, child: Text('Post'),)
              ],
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    if(state is SocialCreatePostLoadingState)
                      LinearProgressIndicator(),
                    if(state is SocialCreatePostLoadingState)
                      SizedBox(
                        height: 10,
                      ),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://media-cdn.tripadvisor.com/media/photo-p/17/da/3e/d2/real-madrid-restaurant.jpg'
                      ),
                    ),
                    Text('Assem hadidi')
                  ],
                ),
                Expanded(
                    child: TextFormField(
                      controller: textController,
                  decoration: InputDecoration(
                    hintText: 'What is on your mind ....',
                    border: InputBorder.none
                  ),
                )
                ),
                if(SocialCubit.get(context).imagePost!=null)
                  Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image:DecorationImage(
                                image: FileImage(SocialCubit.get(context).imagePost!) as ImageProvider,
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        IconButton(onPressed: (){
                          SocialCubit.get(context).removePhoto();
                        }, icon: Icon(Icons.close),),

                      ]
                  ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getImagePost();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              Text('Add photo'),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextButton(
                          onPressed: (){},
                          child: Text('#tags'),
                        )
                    )
                  ],
                ),

              ],
            )
        );
      },
    );
  }
}
