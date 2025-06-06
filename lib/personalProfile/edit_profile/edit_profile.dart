import 'package:firebase/component/component.dart';
import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/utils/StaticValues.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/personalProfile/data/ProfileRepo.dart';
import 'package:firebase/personalProfile/data/remote/ProfileRemote.dart';
import 'package:firebase/personalProfile/edit_profile/cubit/Cubit.dart';
import 'package:firebase/personalProfile/edit_profile/cubit/States.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) =>
          EditProfileCubit(ProfileRepo(ProfileRemote())),
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          nameController.text = StaticValues.userModel!.name!;
          bioController.text = StaticValues.userModel!.bio!;
          phoneController.text = StaticValues.userModel!.phone!;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2),
              ),
              title: const Text('Edit Profile'),
              actions: [
                TextButton(
                    onPressed: () {
                      EditProfileCubit.get(context).updateProfile(
                          nameController.text,
                          bioController.text,
                          phoneController.text);
                    },
                    child: const Text('Update')),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialUpdateSuccessUserState)
                      const LinearProgressIndicator(),
                    SizedBox(
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
                                    margin: const EdgeInsets.all(8),
                                    child: Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        Image(
                                          image: EditProfileCubit.get(context)
                                                      .profileImage ==
                                                  null
                                              ? NetworkImage(
                                                  '${StaticValues.userModel?.cover}')
                                              : FileImage(EditProfileCubit.get(
                                                          context)
                                                      .profileImage!)
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 160,
                                        ),
                                        const Text('Communicate with friends'),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                        onPressed: () {
                                          EditProfileCubit.get(context)
                                              .selectProfileCover();
                                        },
                                        icon: const CircleAvatar(
                                          child: Icon(IconBroken.Camera),
                                        )),
                                  ),
                                ]),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${StaticValues.userModel?.cover}'),
                                  radius: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: () {
                                      EditProfileCubit.get(context)
                                          .selectProfileImage();
                                    },
                                    icon: const CircleAvatar(
                                      child: Icon(IconBroken.Camera),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) return 'Enter a name';
                        },
                        label: 'Name',
                        prefix: IconBroken.User),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        controller: bioController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) return 'Enter a bio';
                        },
                        label: 'Bio',
                        prefix: IconBroken.Info_Circle),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.number,
                        validate: (String value) {
                          if (value.isEmpty) return 'Enter your phone number';
                        },
                        label: 'Phone',
                        prefix: IconBroken.Call),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
