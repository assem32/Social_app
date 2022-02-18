import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/states.dart';
import 'package:firebase/layout/social_layout.dart';
import 'package:firebase/modules/social_app/social_login_screen.dart';
import 'package:firebase/network/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/social_app/social_login_screen.dart';

Future<void> firebaseMessagingBackgroundHnadler(RemoteMessage message)async{
  print(message.data.toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  var token= await FirebaseMessaging.instance.getToken();
  print('token ${token}');

  FirebaseMessaging.onMessage.listen((event) {
    print('on message  ${event.data.toString()}');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on messageopened  ${event.data.toString()}');
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHnadler);

  if (uId != null) {
    widget = SocialLayout();
  } else
    widget = SocialLoginScreen();
  runApp(FireBase(startWidget: widget));
}

class FireBase extends StatelessWidget {
  //const FireBase({Key? key}) : super(key: key);
  final Widget ?startWidget;
  FireBase({ this.startWidget});

  @override
  Widget build(BuildContext context) {
   return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => SocialCubit()..getUserData()..currentIndex..getPost()..getUserDataChat()),
          // BlocProvider(
          //     create: (BuildContext context)=>
          // )
        ],
        child: BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black
                  )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue
                )
              ),
              debugShowCheckedModeBanner: false,
              home: startWidget,
            );
          },
        ));

    //  return MaterialApp(
    //  debugShowCheckedModeBanner: false,
    //  home: startWidget,
    //  );
  }
}
