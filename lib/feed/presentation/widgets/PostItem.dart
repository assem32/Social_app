import 'package:firebase/feed/data/model/PostModel.dart';
import 'package:firebase/feed/presentation/commnet_screen.dart';
import 'package:firebase/modules/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase/component/styel/iconbroken.dart';

class PostItem extends StatelessWidget {
  final PostModel model;
  const PostItem(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.image}'),
                radius: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile(model)));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: const TextStyle(height: 1),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 15,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${model.dateTime}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                color: Colors.grey,
                height: 1,
                width: double.infinity,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${model.text}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, height: 2, fontSize: 15),
                ),
              ],
            ),
            if (model.imagePost != '')
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('${model.imagePost}'))),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              // SocialCubit.get(context).likePost(
                              //     SocialCubit.get(context).postId[index]);
                            },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${model.likesNum}',
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CommentScreen(model.postId!)));
                            },
                            icon: const Icon(
                              IconBroken.Chat,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${model.commentNum}',
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
