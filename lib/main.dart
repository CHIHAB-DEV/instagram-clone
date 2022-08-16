import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/layout/social_app/cubit/cubit.dart';
import 'package:social_media_app/layout/social_app/cubit/states.dart';
import 'package:social_media_app/layout/social_app/social_layout.dart';
// import 'package:social_media_app/modules/1/native_code.dart';
import 'package:social_media_app/modules/social_app/social_login/cubit/cubit.dart';
import 'package:social_media_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:social_media_app/shared/componants.dart';
import 'package:social_media_app/shared/constans.dart';
import 'package:social_media_app/shared/network/local/cashe_helper.dart';
import 'package:social_media_app/shared/network/remote/dio_helper.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('✅on background message✅');
//   print(message.data.toString());
// Fluttertoast.showToast(
//   msg: "✅on background message✅",
//   toastLength: Toast.LENGTH_LONG,
//   gravity: ToastGravity.BOTTOM,
//   timeInSecForIosWeb: 1,
//   backgroundColor: defaultColor,
//   textColor: Colors.white,
//   fontSize: 16.0,
// );
// }

void main() async {
  //تضمن انو الحاجات يلي عليها اوايت تتنفذ بعدها يراان
  WidgetsFlutterBinding.ensureInitialized();

  //set minimum width and height on app
  // if (Platform.isWindows) {
  //   await DesktopWindow.setMaxWindowSize(
  //     Size(500, 500),
  //   );
  // }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = await FirebaseMessaging.instance.getToken();
  print('🌟token🌟 ${token}');

  //TODO:  FIREBASE CLOUD MESSAGING

  //notification ki tkon rak da5l app
  // FirebaseMessaging.onMessage.listen((event) {
  //   print('✅on message ✅');
  //   print(event.data.toString());
  //   Fluttertoast.showToast(
  //     msg: "✅on message ✅",
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: defaultColor,
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  // });

  //notification ki tkon 5arj app
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  //notification ki tkon 5arj app wtclicki 3la notification
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print('✅on message opened app✅');
  //   print(event.data.toString());
  //   Fluttertoast.showToast(
  //     msg: "✅on message opened app✅",
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: defaultColor,
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  // });

  DioHelper.init();
  await CasheHelper.init();

  //ios notification
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // this allow you to take the user permission to send notification
  // NotificationSettings settings
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  Widget? widget;

  uId = CasheHelper.getData(key: 'uId');

  print(uId);

  bool? isDark = await CasheHelper.getData(key: 'isDark');

  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    widget,
    isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool? isDark;

  MyApp(this.startWidget, this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserData()
            ..getPosts()
            ..getUserData()
            ..getUsers()
            ..changeTheme(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: SocialCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,

            // title: 'Flutter Demo',
            // theme: ThemeData(

            //   primarySwatch: Colors.blue,

            // ),
            home: startWidget,
            // home: NativeCodeScreen(),
          );
        },
      ),
    );
  }
}
