import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/addPost/presentation/AddPost.dart';
import 'package:firebase/chat/presentation/chats/ChatScreen.dart';
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChatScreen()));
                }, icon: const Icon(IconBroken.Chat)),
              ],
            ),
            body: SocialCubit.get(context).screen[SocialCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: SocialCubit.get(context).currentIndex,
              onTap: (index){
                SocialCubit.get(context).
                changeNav(index);
              }, items: const [
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
