import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/layout/social_app/cubit/cubit.dart';
import 'package:social_media_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:social_media_app/shared/componants.dart';
import 'package:social_media_app/shared/network/local/cashe_helper.dart';

String? uId = '';

void singOut(context) {
  CasheHelper.removeData(key: 'uId').then((value) {
    CasheHelper.removeData(key: 'isDark').then((value) {
      if (value == true) {
        navigateAndfinish(context, SocialLoginScreen());
      }
    });
  });
}
