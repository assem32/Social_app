import 'package:firebase/component/component.dart';
import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {
  var nameController= TextEditingController();
  var bioController= TextEditingController();
  var phoneController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        var userModel= SocialCubit.get(context).model;
        var profilePic=SocialCubit.get(context).profileImage;
        var profileCover=SocialCubit.get(context).profileCover;
        nameController.text=userModel!.name!;
        bioController.text=userModel.bio!;
        phoneController.text=userModel.phone!;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: Icon(IconBroken.Arrow___Left_2),),
            title: Text('Edit Profile'),
            actions: [
              TextButton(
                  onPressed: (){
                    SocialCubit.get(context).updateUser(bio: bioController.text, name: nameController.text, phone: phoneController.text);
                  },
                  child: Text('Update')
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUpdateSuccessUserState)
                    LinearProgressIndicator(),
                  Container(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 10,
                              margin: EdgeInsets.all(8),
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Image(
                                    image:profileCover == null ? NetworkImage(
                                        '${userModel.cover}') : FileImage(profileCover) as ImageProvider,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 160,
                                  ),
                                  Text('Communicate with friends'),
                                ],
                              ),
                            ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(onPressed: (){
                                  SocialCubit.get(context).getCover();
                                },
                                    icon: CircleAvatar(
                                      child:Icon(IconBroken.Camera) ,
                                    )

                                ),
                              ),
                            ]
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children:[
                            CircleAvatar(
                            radius: 65,
                            backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              backgroundImage: profilePic == null ? NetworkImage(
                                  '${userModel.image}') : FileImage(profilePic) as ImageProvider,
                              radius: 60,
                            ),
                          ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(onPressed: (){
                              SocialCubit.get(context).getImage();
                            },
                                icon: CircleAvatar(
                                  child:Icon(IconBroken.Camera) ,
                                )

                            ),
                          ),],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(SocialCubit.get(context).profileImage!=null ||SocialCubit.get(context).profileCover!=null)
                    Row(
                    children: [
                      if(SocialCubit.get(context).profileImage!=null)
                          Expanded(
                            child: Column(children:
                            [
                               defaultButton(function: (){
                                 SocialCubit.get(context).uploadImage(bio: bioController.text, name: nameController.text, phone: phoneController.text);
                               }, text: 'Upload profile pic'),
                              //LinearProgressIndicator(),
        ],),
                          ),
                      SizedBox(width: 10,),
                      if(SocialCubit.get(context).profileCover!=null)
                        Expanded(
                          child: Column(children: [
                             defaultButton(function: (){
                               SocialCubit.get(context).uploadCover(bio: bioController.text, name: nameController.text, phone: phoneController.text);
                             }, text: 'Upload cover pic'),
                            //LinearProgressIndicator(),
                          ],),
                        )
                         


                    ],
                  ),
                  if(SocialCubit.get(context).profileImage!=null ||SocialCubit.get(context).profileCover!=null)
                    SizedBox(height: 10,),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value){
                        if(value.isEmpty)
                          return 'Enter a name';
                      },
                      label: 'Name',
                      prefix: IconBroken.User
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(controller: bioController,
                      type: TextInputType.text,
                      validate: (String value){
                        if(value.isEmpty)
                          return 'Enter a bio';
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.number,
                      validate: (String value){
                        if(value.isEmpty)
                          return 'Enter your phone number';
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call
                  ),

                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
