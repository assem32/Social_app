import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/component/component.dart';
import 'package:firebase/layout/social_layout.dart';
import 'package:firebase/modules/social_app/social_login_screen.dart';
import 'package:firebase/modules/social_register/cubit/cubit.dart';
import 'package:firebase/modules/social_register/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegister extends StatelessWidget {
  //const SocialRegister({Key? key}) : super(key: key);
  var name=TextEditingController();
  var mail=TextEditingController();
  var phone=TextEditingController();
  var password=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
       create:( BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener:(context,state){
          if(state is SocialCreateUserSuccessState)
          {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SocialLayout(),
              ),
                  (route) {
                return false;
              },
            );
          }
        },
        builder: (context,state)
    {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => SocialLoginScreen()));
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Padding(padding: EdgeInsets.all(20),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('Register',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),
                    ),
                    Text('Register now to get connect',
                      style: TextStyle(fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(controller: name
                        , type: TextInputType.name
                        , validate: (String value) {
                          if(value.isEmpty)
                            return 'You have to enter a name';
                        }
                        , label: 'Name'
                        , prefix: Icons.account_circle,
                        onChange: (String value){
                          print(value);
                        }
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(controller: mail
                        , type: TextInputType.emailAddress
                        , validate: (String value) {
                          if(value.isEmpty)
                            return 'You have to enter an E-mail';
                        }
                        , label: 'E-mail'
                        , prefix: Icons.mail,
                        onChange: (String value){
                          print(value);
                        }
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(controller: phone
                        , type: TextInputType.number
                        , validate: (String value) {
                          if(value.isEmpty)
                            return 'You have to enter a number';
                        }
                        , label: 'Phone Number'
                        , prefix: Icons.phone,
                        onChange: (String value){
                          print(value);
                        }
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(controller: password
                        , type: TextInputType.text
                        , validate: (String value) {
                          if(value.isEmpty)
                            return 'You have to enter a password';
                        }
                        , label: 'Password'
                        , prefix: Icons.lock,
                        onChange: (String value){
                          print(value);
                        },
                      suffix: SocialRegisterCubit.get(context).suffix,
                      isPass: SocialRegisterCubit.get(context).isPassWord,
                      suffixPressed:() {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          }),
                    SizedBox(
                      height: 15,
                    ),

                    ConditionalBuilder(condition: state is! SocialRegisterLoadingState,
                        builder:(context)=> defaultButton(function:() {
                          if (formKey.currentState!.validate()) {
                            SocialRegisterCubit.get(context).userRegister
                              (
                              name: name.text,
                              mail: mail.text,
                              pass: password.text,
                              phone: phone.text,
                            );
                          }
                        },
                        text: 'Register'),
                        fallback: (context)=> Center(child: CircularProgressIndicator(),))


          ],
        ),
      ),)
      )
      )
      );
    }
      )
    );
  }
}
