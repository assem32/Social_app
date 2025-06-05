import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/personalProfile/data/ProfileRepo.dart';
import 'package:firebase/personalProfile/data/remote/ProfileRemote.dart';
import 'package:firebase/personalProfile/edit_profile/edit_profile.dart';
import 'package:firebase/personalProfile/personalProfilePresentation/cubit/PersonalProfileCubit.dart';
import 'package:firebase/personalProfile/personalProfilePresentation/cubit/PersonalProfileState.dart';
import 'package:firebase/personalProfile/personalProfilePresentation/widgets/PersonalDetails.dart';
import 'package:firebase/personalProfile/personalProfilePresentation/widgets/PersonalPostItem.dart';
import 'package:firebase/personalProfile/personalProfilePresentation/widgets/PostsDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> PersonalProfileCubit(ProfileRepo(ProfileRemote()))..getProfileData()..getProfilePosts(),
      child: BlocConsumer<PersonalProfileCubit, PersonalProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                PersonalDetails(PersonalProfileCubit.get(context).userModel),
                PostsDetails(PersonalProfileCubit.get(context).postsList.length),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: ()async {
                            
                          },
                          child: Text('Edit profile')),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()));
                        },
                        child: Icon(
                          IconBroken.Edit,
                        )),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: PersonalProfileCubit.get(context).postsList.length,
                      itemBuilder: (context, index) => PersonalPostItem(
                          PersonalProfileCubit.get(context).postsList[index].image!),
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
      ),
    );
  }
}
