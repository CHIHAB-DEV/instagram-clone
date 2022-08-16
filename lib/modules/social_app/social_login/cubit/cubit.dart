import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/modules/social_app/social_login/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  // UserModel? userModel;

  // SocialLoginModel? LoginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    print('~~~LOADING LOGIN~~~');

    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      print('🌟SUCCESS LOGIN🌟');

      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print('🛑ERROR LOGIN🛑');
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData? suffixIcon = Icons.visibility_rounded;
  bool isPassword = true;

  void ChangePasswordVisibilty() {
    isPassword = !isPassword;
    suffixIcon = isPassword == true
        ? Icons.visibility_rounded
        : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityState());
  }
}
