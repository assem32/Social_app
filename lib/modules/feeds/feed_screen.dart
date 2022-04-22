import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/model/add_post.dart';
import 'package:firebase/modules/comment/commnet_screen.dart';
import 'package:firebase/modules/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).post.length>0,
          builder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/surprised-stupefied-european-young-male-with-shocked-expression-wears-casual-checkered-shirt-points-with-index-finger-upper-right-corner-has-dark-bristle-isolated-white-wall_273609-16028.jpg'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      Text('Communicate with friends'),
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>buildPost(SocialCubit.get(context).post[index],context,index),
                    separatorBuilder: (context,index)=>SizedBox(
                      height: 8,
                    ),
                    itemCount: SocialCubit.get(context).post.length),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPost(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('${model.image}'),
                  radius: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(model)));
                      },
                      child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(height: 1),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 15,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${model.dateTime}',
                        style: TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
                    )),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
              ]),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
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
                    style: TextStyle(
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
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            IconButton(
                            icon: Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              SocialCubit.get(context)
                                  .likePost(SocialCubit.get(context).postId[index]);
                            },
                          ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentScreen(SocialCubit.get(context).postId[index],)));
                              },
                              icon: Icon(
                                IconBroken.Chat,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).comments[index]}',
                              style: TextStyle(color: Colors.grey),
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
