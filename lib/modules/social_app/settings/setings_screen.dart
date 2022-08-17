import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/layout/social_app/cubit/cubit.dart';
import 'package:social_media_app/layout/social_app/cubit/states.dart';
import 'package:social_media_app/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:social_media_app/modules/social_app/new_post/new_post_screen.dart';
import 'package:social_media_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:social_media_app/shared/componants.dart';
import 'package:social_media_app/shared/constans.dart';
import 'package:social_media_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: ((context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 210.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              userModel?.cover ??
                                  'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw8PEA8PDQ8QDQ0NDw8NDQ0NDxANDQ0NFRIWFhURFRUYHSggGBolHRUVITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OFxAQGi0lFx0tKysrLS0tLS0tLS0rKystLSstLS0tLS0rNy0tNy0tKzc3KystKy0rLSsrKystKysrK//AABEIAIABigMBIgACEQEDEQH/xAAbAAEBAAMBAQEAAAAAAAAAAAAAAQIEBQMGB//EADUQAQABAgMFBwEHBAMAAAAAAAABAhEDITEEBSJBURITFDJTYaGBI0Jxc4Ky4VJykfBDwdH/xAAXAQEBAQEAAAAAAAAAAAAAAAAAAgED/8QAGxEBAQEBAAMBAAAAAAAAAAAAAAERMRIhUQL/2gAMAwEAAhEDEQA/AP1YB1cxFQBQARUBUJAAUEUAIlFQFQAUEkFQAFRQSRSAAACAARUBQAEVAVFAEUAAARUBQAQAAIAUAAQBQABAFEUARQAgARSAIRQAAARQC7Ga4jKZzIxKesZ6AyRjGJHWM9CMSMs4z0BkMYrjrGemerIFEsAogCgACAKAAIAoAAgCgACAKioCgAAAAAAASgoAESAioCgAXAASZ66K094bR3dM1RHFfsUX8ul5qsDZ7ynrGl/oxxMaIiZmezTFpmqdLdI93BnbMX1K/pNnniY1dXnqqqtp2pmbK8U+Tax941zNsP7OjlEeafeZeXjsb1KvhrjcZrY8djepV8Hjsb1KvhrhjNbeFvHFic6u3HOmq2f1dfZsemqntU3mnnGtVE9J9nzrLDxKqZvTVNM9aZsWNlfSziU9Y92US+c8Zi+pX/l0t3bXNcVdrzUWqmqI89PumxUrpAMaAAAAAAAAAAAAAAAAISAoAAICgAAgAKAigIoAQioCooA5e+Y4afzJ+vC6jl758tP5k/tbOsvHJAWhYpmZiIi8zlERzl1tl3XTGeJxVf0x5Y/9eW5sG81Vz93hp/GdZ/3qu9drmJ7uibREccxrN+Sb8VPrd7GDGVsOPbhu8to3bRV5eCrlMeWfo4dm7u7a5oqimZvRVNrT92Z0mDDY1sbCmiZpqi0x/t2Ds74wb0RXzom0/wBsuM2XWWYN/dE8WJy+z16cUNBvbonixOX2ev6oLwjuSCIWoAAICgAAgKAACAqKAIqQAKWAC6AohcFBAULoCygAKigBAACAsIqArl75jhj8yf2uo5e+Y4afzJ/a2dZeOSAtDr7lngqjnFV/ho7ypmMWu/Oe1H4TBu/ae7rz8tWVXt0l1tr2SnFiJvaqI4aozy/7hPKrscBlh0zM0xGszER/ltzuvFv92fe7e2HYIw57VU9qvlbSn8C2MxnvObYVfvaPreHBdDeu1RVMUUzemmbzMaTV/Dnn54Ub26fNicuDX9UNFvbpnixOXBr+qG0juSEpdC1EuAohcFC6Aoly4KCXBRLlwUEuCoqAKICgAAAAAAAShICglgBQACAEUAcvfPlpy/5J158LqNPbtm7ymadJvFdMzpM2tMEZXBGzOwY3pz9LSngMb06vheoxrtjZtsrw8qZvT/TVnH8L4HG9Or4PA43p1fB6b7bUb3n04v8A3fw19o3hiVxbyUzrFPP6sPAY3p1fB4DG9Or4ZkPbXGx4DG9Or4XwGN6dXw3WY1m9uieLE5cGv6oeXgMb06vh0N37HOHftZV15WjPs0xN5uWtkdEBCwAAAAAAIAAAAAAAQCAWEVLAAoIKAiooIKgAACpZQEUABAUABJi+uce8XVAScOnpGeuSd3TnlGeejMBh3dPSM9Tu6ekZs4AYThx0jPUnDpzyjNmAwnDjpGep3dPSM9WaAxnDjpGerKKYjKIiPwABQBFRQRRAFAEBQAQBUUBFQAAFS4AoAAAAAAACLKAKAEAAAAAAIoCKAAgAtkAVFQBYCIAAAAAAAAAAAAAAAABAAVAB/9k=',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                          userModel?.image ??
                              'data:image/png;base64,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',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                userModel?.name ?? 'user name',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 7.0,
              ),
              Text(
                userModel?.bio ?? 'your bio here',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '69',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '355',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '281',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            Text(
                              'Folowing',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        // backgroundColor: Colors.grey,
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      onPressed: () {
                        navigatorTo(context, NewPostScreen());
                      },
                      child: const Text(
                        'Add Photos',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    onPressed: () {
                      navigatorTo(context, EditProfielScreen());
                    },
                    child: const Icon(
                      IconBroken.Edit,
                      size: 22.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      onPressed: () {
                        print('follow');
                        FirebaseMessaging.instance
                            .subscribeToTopic('announcements');

                        Fluttertoast.showToast(
                          msg: "FOLLOW",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: defaultColor,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: const Text('Follow'),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      onPressed: () {
                        print('unfollow');

                        FirebaseMessaging.instance
                            .unsubscribeFromTopic('announcements');

                        Fluttertoast.showToast(
                          msg: "UnFollow",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: defaultColor,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: const Text('UnFollow'),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                onPressed: () {
                  singOut(context);
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
