import 'package:firebase/auth/data/model/UserModel.dart';
import 'package:flutter/material.dart';

class PersonalDetails extends StatelessWidget {
  final UserModel? userModel;
  const PersonalDetails(this.userModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Align(
                child: Card(
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
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${userModel?.image}'),
                  radius: 60,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '${userModel?.name}',
        ),
        Text(
          '${userModel?.bio}',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
