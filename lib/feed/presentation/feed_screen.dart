import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/feed/data/FeedRepo.dart';
import 'package:firebase/feed/data/remote/FeedRemote.dart';
import 'package:firebase/feed/presentation/cubit/FeedCubit.dart';
import 'package:firebase/feed/presentation/cubit/FeedStates.dart';
import 'package:firebase/feed/presentation/widgets/PostItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FeedCubit(FeedRepo(FeedRemote()))..getPost(),
      child: BlocConsumer<FeedCubit,FeedState>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
            condition: FeedCubit.get(context).post.length>0,
            builder: (context)=>SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  const Card(
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=>PostItem(FeedCubit.get(context).post[index]),
                      separatorBuilder: (context,index)=>const SizedBox(
                        height: 8,
                      ),
                      itemCount: FeedCubit.get(context).post.length),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
