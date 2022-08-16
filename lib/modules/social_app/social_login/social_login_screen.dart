import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:social_media_app/layout/social_app/social_layout.dart';
import 'package:social_media_app/modules/social_app/social_register/social_register_screen.dart';
import 'package:social_media_app/shared/network/local/cashe_helper.dart';

import '../../../shared/componants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);

  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            MotionToast.error(
              height: 110,
              title: const Text("Error"),
              description: Text(state.error),
            ).show(context);
          }
          if (state is SocialLoginSuccessState) {
            CasheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndfinish(
                context,
                const SocialLayout(),
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                          //  TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 40.0,
                          //     fontWeight: FontWeight.bold),
                        ),
                        Text('Login now to communicate with friends',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 20.0,
                                    )
                            // TextStyle(
                            //   color: Colors.grey,
                            //   fontSize: 20.0,
                            // ),
                            ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        defaultFormField(
                          context,
                          label: 'Email Address',
                          prefixIcon: Icons.mail_outline,
                          controller: emailcontroller,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        defaultFormField(context,
                            label: 'Password',
                            prefixIcon: Icons.lock,
                            controller: passwordcontroller,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your password';
                              }
                            },
                            isPassword:
                                SocialLoginCubit.get(context).isPassword,
                            suffixIcon:
                                SocialLoginCubit.get(context).suffixIcon,
                            suffixPressed: () {
                              SocialLoginCubit.get(context)
                                  .ChangePasswordVisibilty();
                            }),
                        const SizedBox(
                          height: 25.0,
                        ),
                        state is! SocialLoginLoadingState
                            ? defaultButton(
                                text: 'Login',
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text,
                                    );
                                  }
                                },
                              )
                            : const Center(child: CircularProgressIndicator()),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'don\'t have an accounte ?',
                            ),
                            defualtTextButton(
                              text: 'Register',
                              function: () {
                                navigatorTo(context, SocialRegisterScreen());
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
