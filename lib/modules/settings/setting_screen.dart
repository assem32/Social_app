import 'package:firebase/component/component.dart';
import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/edit_profile/edit_profile.dart';
import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        var userModel= SocialCubit.get(context).model;
        SocialCubit.get(context).profilePost(SocialCubit.get(context).model?.uId);
        return Padding(
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
                            Image(
                              image: NetworkImage(
                                  '${userModel?.cover}'),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 160,
                            ),
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
                            '${userModel?.image}'),
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
                  '${userModel?.name}',
              ),
              Text(
                '${userModel?.bio}',
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
                      'Edit profile'
                    )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                  },
                      child: Icon(
                    IconBroken.Edit,
                  )),
                ],
              ),
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: SocialCubit.get(context).userData.length,
                    itemBuilder: (context,index)=>buildProfileImage(SocialCubit.get(context).userData[index]),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1)),
              )
            ],
          ),
        );
      },

    );
  }
}
