import 'package:firebase/component/component.dart';
import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var searchController=TextEditingController();
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: ((context,index){}),
      builder: ((context,index){
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'Search....',
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                    SocialCubit.get(context).searchUser(searchController.text);
                  }, icon: Icon(Icons.search))
                ],
              ),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(itemBuilder: (context,index)=>searchItem(SocialCubit.get(context).SearchUser[index],context),
                  separatorBuilder: (context,index)=>SizedBox(height: 15,),
                  itemCount: SocialCubit.get(context).SearchUser.length)
          ),
        );
      }),
    );
  }
}
