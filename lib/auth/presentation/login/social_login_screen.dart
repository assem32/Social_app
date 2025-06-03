import 'package:firebase/auth/data/AuthRepo.dart';
import 'package:firebase/auth/data/remote/AuthRemote.dart';
import 'package:firebase/auth/presentation/login/widgets/LoginHeader.dart';
import 'package:firebase/auth/presentation/login/widgets/NewAccountRow.dart';
import 'package:firebase/component/component.dart';
import 'package:firebase/layout/social_layout.dart';
import 'package:firebase/auth/presentation/login/cubit/cubit.dart';
import 'package:firebase/auth/presentation/login/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var email = TextEditingController();
    var pass = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) =>
          SocialLoginCubit(Authrepo(AuthRemote())),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          listener: (context, state) {
        if (state is SocialSuccessLoginState) {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => SocialLayout()),
              (route) {
            return false;
          });
        }
      }, builder: (context, state) {
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
                      const LoginHeader(),
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
                      ),
                      const SizedBox(
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
                        suffixPressed: () {
                          SocialLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        text: 'Login',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context)
                                .loginHandler(email.text, pass.text);
                          } else
                            return null;
                        },
                      ),
                      const NewAccountRow()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
