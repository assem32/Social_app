import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/modules/add_post/add_post.dart';
import 'package:firebase/modules/chats/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){
        if(state is SocialAddPost){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPost(),
            ),
          );
        }
      },
      builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(SocialCubit.get(context).title[SocialCubit.get(context).currentIndex]),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                }, icon: Icon(IconBroken.Chat)),
              ],
            ),
            body: SocialCubit.get(context).screen[SocialCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: SocialCubit.get(context).currentIndex,
              onTap: (index){
                SocialCubit.get(context).
                changeNav(index);
              }, items: [
              BottomNavigationBarItem(
                  icon:  Icon(IconBroken.Home),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Search),
                  label: 'Search'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload),
                  label: 'Add post'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Profile),
                label: 'Profile',
              ),
            ],
            ),

          );
      },
    );

  }
}
// Container(
// // height: 40,
// color: Colors.grey.withOpacity(0.6),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20.0),
// child: Row(
// children: [
// Icon(Icons.info_outline),
// SizedBox(width: 10,),
// Expanded(child: Text('Please verify your email')),
// SizedBox(
// width: 20,
// ),
// TextButton(onPressed: () {
// FirebaseAuth.instance.currentUser!
//     .sendEmailVerification()
//     .then((value){
// print('success');
// }).catchError((error)
// {
// print(error);
// });
// }, child: Text('send')),
// ],
// ),
// ),
// )
//ConditionalBuilder(
//   condition: SocialCubit.get(context).model !=null,
//   builder: (context){
//     //var model=FirebaseAuth.instance.currentUser!.emailVerified;
//     return Column(
//       children: [
//
//       ]
//
//
//     );
//   }
//   ,fallback: (context)=> Center(child :CircularProgressIndicator()),
// )