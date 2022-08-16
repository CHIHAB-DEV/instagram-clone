import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/models/social_user_model.dart';
import 'package:social_media_app/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // UserModel? userModel;

  // SocialLoginModel? RegisterModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    print('~~~LOADING REGISTER~~~');

    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      print('🌟SUCCESS REGISTER🌟');
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print('🛑ERROR REGISTER🛑');
      emit(
        SocialRegisterErrorState(error.toString()),
      );
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    socialUserModel model = socialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ...',
      cover:
          'https://img.freepik.com/premium-photo/delivery-concept-with-motorcycle-road-logistics-copy-space-3d-illustration_522591-2290.jpg?w=1800',
      image:
          'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?t=st=1658339938~exp=1658340538~hmac=c6204f156f5d1a59c704d267aa772eec87411bd5645f130fe2ca934e8a19eaa5&w=2000',
      isEmailVirified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
          model.toMap(),
        )
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData? suffixIcon = Icons.visibility_rounded;
  bool isPassword = true;

  void ChangePasswordVisibilty() {
    isPassword = !isPassword;
    suffixIcon = isPassword == true
        ? Icons.visibility_rounded
        : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityStatee());
  }
}
