import 'package:firebase/component/component.dart';
import 'package:firebase/layout/social_layout.dart';
import 'package:firebase/modules/social_app/cubit/cubit.dart';
import 'package:firebase/modules/social_app/cubit/states.dart';
import 'package:firebase/modules/social_register/social_register.dart';
import 'package:firebase/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
       create: (BuildContext context) => SocialLoginCubit(),
       child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
         listener: (context,state){
           if(state is SocialSuccessLoginState)
           {
             CacheHelper.saveData(key: 'uId', value: state.uId)
           .then((value){
             Navigator.pushAndRemoveUntil(context,
                 MaterialPageRoute(builder: (context)=>SocialLayout())
             ,(route){
               return false;
                 }
             );
             });

           }
         },
         builder: (context,state){
           return Scaffold(
             body: Center(
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(20),
                   child: Form(
                     key: formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text('Login',
                           style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)
                         ),
                         Text(
                           'Connect with your friends'
                           ,style: TextStyle(fontWeight:FontWeight.bold)
                         ),
                         SizedBox(height: 20,),
                         defaultFormField(
                           type: TextInputType.emailAddress,
                           onSubmit: (String value) {
                             print(value);
                           },
                           label: 'E-mail',
                           controller: email,
                           prefix: Icons.email,
                           validate: (String value) {
                             if (value.isEmpty) {
                               return 'Please enter some text';
                             }
                             return null;
                           },
                           // onChange: (String ?value){
                           //   print(value);
                           // }
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         defaultFormField(
                           controller: pass,
                           type: TextInputType.text,
                           validate: (String value) {
                             if (value.isEmpty) {
                               return 'password is to short';
                             }
                           },
                           label: 'pass',
                           prefix: Icons.lock,
                           suffix: SocialLoginCubit.get(context).suffix,
                           isPass: SocialLoginCubit.get(context).isPassWord,
                           suffixPressed:() {
                             SocialLoginCubit.get(context)
                                 .changePasswordVisibility();
                           },
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         defaultButton(
                           text: 'Login',
                           function: () {
                             if (formKey.currentState!.validate()) {
                               SocialLoginCubit.get(context).userLogin(mail: email.text, pass: pass.text);

                             } else
                               return null;
                           },
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment:CrossAxisAlignment.center,
                           children: [
                             Text('Don\'t have an account?'),
                             TextButton(child: Text('Register'),
                               onPressed: (){
                               Navigator.push(context,
                                 MaterialPageRoute(builder: (context)=> SocialRegister()),

                               );
                               },)
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ),
             ),
           );
         }

       ),
     );
  }
}
