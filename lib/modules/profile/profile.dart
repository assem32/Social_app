import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/model/add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {

  PostModel ?profileModel;
  Profile(this.profileModel);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){

        return Scaffold(
          appBar: AppBar(

          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 220,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child:  Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          margin: EdgeInsets.all(8),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                            ],
                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 65,
                        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${profileModel?.image}'),
                          radius: 60,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${profileModel?.name}',
                ),
                Text(
                  '${profileModel?.bio}',
                  style: TextStyle(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('Posts'),
                            Text('100',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                      Expanded(child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('Posts'),
                            Text('100',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                      Expanded(child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('Posts'),
                            Text('100',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                      Expanded(child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('Posts'),
                            Text('100',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(onPressed: (){},
                          child: Text(
                              'Follow'
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
