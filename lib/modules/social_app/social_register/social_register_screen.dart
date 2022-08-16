import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/layout/social_app/social_layout.dart';

import '../../../shared/componants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);

  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndfinish(context, SocialLayout());
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
                        Text('REGISTER',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                    )
                            // TextStyle(
                            //   color: Colors.black,
                            //   fontSize: 40.0,
                            //   fontWeight: FontWeight.bold,
                            // ),
                            ),
                        Text('Register now to communicate with friends',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 20.0,
                                    )
                            //  TextStyle(
                            //   color: Colors.grey,
                            //   fontSize: 20.0,
                            // ),
                            ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        defaultFormField(
                          label: 'Full Name',
                          prefixIcon: Icons.person,
                          controller: namecontroller,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        defaultFormField(
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
                        defaultFormField(
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
                                SocialRegisterCubit.get(context).isPassword,
                            suffixIcon:
                                SocialRegisterCubit.get(context).suffixIcon,
                            suffixPressed: () {
                              SocialRegisterCubit.get(context)
                                  .ChangePasswordVisibilty();
                            }),
                        const SizedBox(
                          height: 25.0,
                        ),
                        defaultFormField(
                          label: 'Phone Number',
                          prefixIcon: Icons.phone,
                          controller: phonecontroller,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        state is! SocialRegisterLoadingState
                            ? defaultButton(
                                text: 'register',
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context)
                                        .userRegister(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text,
                                      name: namecontroller.text,
                                      phone: phonecontroller.text,
                                    );
                                  }
                                },
                              )
                            : const Center(child: CircularProgressIndicator()),
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
