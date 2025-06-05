import 'dart:io';

import 'package:firebase/addPost/data/AddPostRepo.dart';
import 'package:firebase/addPost/data/local/AddPostLocal.dart';
import 'package:firebase/addPost/data/remote/AddPostsRemote.dart';
import 'package:firebase/addPost/presentation/cubit/AddPostsCubit.dart';
import 'package:firebase/addPost/presentation/cubit/AddPostsStates.dart';
import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

File? path;

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) =>
          AddPostsCubit(AddPostRepo(AddPostLocal(), AddPostsRemote())),
      child: BlocConsumer<AddPostsCubit, AddPostsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Left_2),
                ),
                title: Text('Create Post'),
                actions: [
                  TextButton(
                    onPressed: () {
                      var now = DateTime.now();
                      UserModel userModel = UserModel(
                        name: "assem a",
                        phone: "444",
                        bio: "hello there",
                        cover:
                            "https://firebasestorage.googleapis.com/v0/b/assemprroject.appspot.com/o/user%2Fimage_picker2691296912576509660.webp?alt=media&token=4ac9b61e-4cdc-4ada-a00d-57d5a1f58f6e",
                        image:
                            "https://firebasestorage.googleapis.com/v0/b/assemprroject.appspot.com/o/user%2Fimage_picker595847841072782088.jpg?alt=media&token=320a9c62-95b4-45af-b5fd-6802761e1cc6",
                        isMailVer: false,
                        mail: "assem@hotmail.com",
                        uId: "oeveka1sXOgBIN3F5BRobck7yDF3",
                      );
                      AddPostsCubit.get(context).uploadPost(
                          userModel,
                          AddPostsCubit.get(context).imageFile,
                          textController.text,
                          now.toString());
                    },
                    child: Text('Post'),
                  )
                ],
              ),
              body: Column(
                children: [
                  Row(
                    children: [
                      if (state is SocialCreatePostLoadingState)
                        LinearProgressIndicator(),
                      if (state is SocialCreatePostLoadingState)
                        SizedBox(
                          height: 10,
                        ),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://media-cdn.tripadvisor.com/media/photo-p/17/da/3e/d2/real-madrid-restaurant.jpg'),
                      ),
                      Text('Assem hadidi')
                    ],
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'What is on your mind ....',
                        border: InputBorder.none),
                  )),
                  if (AddPostsCubit.get(context).imageFile != null)
                    Stack(alignment: AlignmentDirectional.topEnd, children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: FileImage(
                                  AddPostsCubit.get(context).imageFile!),
                              fit: BoxFit.cover,
                            )),
                      ),
                      IconButton(
                        onPressed: () {
                          // SocialCubit.get(context).removePhoto();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ]),
                  Row(
                    children: [
                      Expanded(
                          child: TextButton(
                        onPressed: () async {
                          AddPostsCubit.get(context).getImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            Text('Add photo'),
                          ],
                        ),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextButton(
                        onPressed: () {},
                        child: Text('#tags'),
                      ))
                    ],
                  ),
                ],
              ));
        },
      ),
    );
  }
}
