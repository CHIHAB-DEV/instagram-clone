import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_media_app/layout/social_app/cubit/cubit.dart';
import 'package:social_media_app/shared/styles/icon_broken.dart';

const defaultColor = Colors.cyan;
// const defaultColor = Color(0xFF7B1206);

const storyColor = [
  Color(0xFF9B2282),
  Color(0xFFEEA863),
];

PreferredSizeWidget? defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      titleSpacing: 0.0,
      centerTitle: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      title: Text(
        title!,
      ),
      actions: actions,
    );

void navigateAndfinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

ThemeData darkTheme = ThemeData(
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    caption: TextStyle(
      color: Colors.white,
    ),
    subtitle2: TextStyle(
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 12.0,
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  fontFamily: 'TaiHeritagePro',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: const Color(0xFF121212),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 27.0,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.white,
    elevation: 20.0,
    backgroundColor: Color(0xFF121212),
  ),
);

ThemeData lightTheme = ThemeData(
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  textTheme: const TextTheme(
    caption: TextStyle(
      color: Colors.black,
    ),
    subtitle2: TextStyle(
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 12.0,
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'TaiHeritagePro',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 27.0,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.black,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
);
void navigatorTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

Widget defualtTextButton({
  required String text,
  required Function()? function,
}) {
  return TextButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 18.0,
      ),
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 10.0,
  required String text,
  required Function function,
}) =>
    Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          // to upper case dima lktiba  li tktbha yrdha capital abc => ABC
          style: const TextStyle(
            fontSize: 17.0,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField(context,
        {required String label,
        required IconData prefixIcon,
        IconData? suffixIcon,
        required TextEditingController controller,
        //l7aja li mktoba tt7t hna fi controller

        required TextInputType type,
        bool isPassword = false,
        void Function(String)? onChange,
        Function? onSubmit,
        required String? Function(String?)? validate,
        Function? suffixPressed,
        void Function()? onTap,
        bool isClickable = true}) =>
    TextFormField(
      enabled: isClickable,
      onTap: onTap,
      controller: controller,
      style: Theme.of(context).scaffoldBackgroundColor == Colors.white
          ? TextStyle(fontSize: 20, color: Colors.black)
          : TextStyle(fontSize: 20, color: Colors.white),
      obscureText: isPassword,
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: (String? s) {
        onSubmit!(s);
      },
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).scaffoldBackgroundColor == Colors.white
            ? TextStyle(fontSize: 20, color: Colors.black)
            : TextStyle(fontSize: 20, color: Colors.white),
        prefixIcon: Icon(
          prefixIcon,
          color: Theme.of(context).scaffoldBackgroundColor == Colors.white
              ? Colors.black
              : Colors.white,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color:
                      Theme.of(context).scaffoldBackgroundColor == Colors.white
                          ? Colors.black
                          : Colors.white,
                ),
                onPressed: () {
                  suffixPressed!();
                },
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
