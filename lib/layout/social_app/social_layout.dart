import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:social_media_app/layout/social_app/cubit/cubit.dart';
import 'package:social_media_app/layout/social_app/cubit/states.dart';
import 'package:social_media_app/modules/social_app/new_post/new_post_screen.dart';
import 'package:social_media_app/modules/social_app/search/search_screen.dart';
import 'package:social_media_app/shared/componants.dart';
import 'package:social_media_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: ((context, state) {
        if (state is SocialNewPostState) {
          navigatorTo(context, NewPostScreen());
        }
      }),
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).userModel;

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              cubit.titles[cubit.currentIndex!],
            ),
            actions: [
              if (cubit.currentIndex == 0)
                IconButton(
                  onPressed: () {
                    navigatorTo(context, NewPostScreen());
                  },
                  icon: const Icon(
                    IconBroken.Plus,
                  ),
                ),
              if (cubit.currentIndex == 0)
                IconButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: "LIKE",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: defaultColor,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                  icon: const Icon(
                    IconBroken.Heart,
                  ),
                ),
              if (cubit.currentIndex == 0)
                IconButton(
                  onPressed: () {
                    navigatorTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    IconBroken.Search,
                  ),
                ),
              if (cubit.currentIndex == 3)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconBroken.Buy,
                  ),
                ),
              if (cubit.currentIndex == 4)
                IconButton(
                  onPressed: () {
                    SocialCubit.get(context).changeTheme();
                  },
                  icon: Icon(
                    SocialCubit.get(context).themeIcon,
                  ),
                ),
              if (cubit.currentIndex == 4)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                  ),
                ),
              if (cubit.currentIndex == 1)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconBroken.Video,
                  ),
                ),
              if (cubit.currentIndex == 1)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
            ],
          ),
          body: cubit.screeens[cubit.currentIndex!],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            selectedIconTheme: const IconThemeData(size: 35.0),
            unselectedIconTheme: const IconThemeData(size: 30.0),
            currentIndex: cubit.currentIndex!,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Plus,
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Bag_2,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                // icon: ImageIcon(
                //   NetworkImage(cubit.userModel!.image!),
                //   size: cubit.currentIndex == 4 ? 40.0 : 30.0,
                // ),
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    userModel?.image ??
                        'https://webriti.com/wp-content/themes/themeshop/images/testimonial/no-image.png',
                    fit: BoxFit.cover,
                    height: cubit.currentIndex == 4 ? 35.0 : 30.0,
                    width: cubit.currentIndex == 4 ? 35.0 : 30.0,
                  ),
                ),

                label: '',

                // icon: Icon(
                //   IconBroken.Setting,
                //   size: cubit.currentIndex == 4 ? 40.0 : 30.0,
                // ),
              ),
            ],
          ),
        );
      },
    );
  }
}
