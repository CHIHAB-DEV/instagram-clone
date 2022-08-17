// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:social_media_app/layout/social_app/cubit/cubit.dart';
import 'package:social_media_app/layout/social_app/cubit/states.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/models/social_user_model.dart';
import 'package:social_media_app/modules/social_app/new_post/new_post_screen.dart';
import 'package:social_media_app/shared/componants.dart';
import 'package:social_media_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  // final keyRefresh = GlobalKey<RefreshIndicatorState>();
  Future<void> refresh() {
    return Future.delayed(
      Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: ((context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty &&
              SocialCubit.get(context).userModel?.image != null &&
              SocialCubit.get(context).users.isNotEmpty,
          // SocialCubit.get(context).userModel?.uId != null &&

          builder: ((context) {
            return RefreshIndicator(
              onRefresh: () async {
                SocialCubit.get(context).getPosts();
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsetsDirectional.only(
                    //     bottom: 10.0,
                    //     start: 10.0,
                    //     end: 10.0,
                    //   ),
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 100,
                    //     child: Row(
                    //       children: [
                    //         buildMyStory(context),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    if (SocialCubit.get(context).userModel!.name ==
                        'Chihab 🫶🏻')
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 125,
                        width: double.infinity,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return buildStoryItem(
                              context,
                              SocialCubit.get(context).users[index],
                              SocialCubit.get(context).userModel,
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: 5.0,
                          ),
                          itemCount: SocialCubit.get(context).users.length,
                        ),
                      ),
                    // SizedBox(
                    //   height: 0,
                    // ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 5.0,
                        start: 4.0,
                        end: 4.0,
                        bottom: 10,
                      ),
                      child: InkWell(
                        onTap: (() {
                          navigatorTo(context, NewPostScreen());
                        }),
                        child: Card(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          elevation: 5.0,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 5,
                                top: 15,
                                bottom: 15,
                                end: 5,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 23,
                                    backgroundImage: NetworkImage(
                                      SocialCubit.get(context)
                                          .userModel!
                                          .image!,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                        height: 45,
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                          // ignore: sort_child_properties_last
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 15.0),
                                            child: Text(
                                              'What\'s on your mind?',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                            .scaffoldBackgroundColor ==
                                                        Colors.white
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                        )

                                        // TextFormField(
                                        //   style: Theme.of(context)
                                        //               .scaffoldBackgroundColor ==
                                        //           Colors.white
                                        //       ? TextStyle(
                                        //           fontSize: 17,
                                        //           color: Colors.black)
                                        //       : TextStyle(
                                        //           fontSize: 17,
                                        //           color: Colors.white,
                                        //         ),
                                        //   maxLines: 1,
                                        //   decoration: InputDecoration(
                                        //     enabledBorder: OutlineInputBorder(
                                        //       borderRadius:
                                        //           BorderRadius.circular(25),
                                        //       borderSide: BorderSide(
                                        //         // width: 3,
                                        //         color: Colors.grey,
                                        //       ),
                                        //     ),
                                        //     focusedBorder: OutlineInputBorder(
                                        //       borderRadius:
                                        //           BorderRadius.circular(25),
                                        //       borderSide:
                                        //           BorderSide(color: Colors.grey),
                                        //     ),
                                        //     hintText: ' what\'s on your mind?',
                                        //     hintStyle: Theme.of(context)
                                        //                 .scaffoldBackgroundColor ==
                                        //             Colors.white
                                        //         ? TextStyle(
                                        //             color: Colors.black,
                                        //             fontSize: 17,
                                        //           )
                                        //         : TextStyle(
                                        //             color: Colors.white,
                                        //             fontSize: 17,
                                        //           ),
                                        //     border: InputBorder.none,
                                        //   ),
                                        // ),

                                        ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      navigatorTo(context, NewPostScreen());
                                    },
                                    icon: Icon(
                                      IconBroken.Image_2,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Card(
                    //   clipBehavior: Clip.antiAliasWithSaveLayer,
                    //   elevation: 6.0,
                    //   margin: EdgeInsets.all(8.0),
                    //   child: Stack(
                    //     alignment: AlignmentDirectional.centerEnd,
                    //     children: const [
                    //       Image(
                    //         image: NetworkImage(
                    //           'https://img.freepik.com/free-photo/stunned-man-looks-with-great-surprisement-fear-aside-opens-mouth-widely-wears-hat-round-glasses_273609-38441.jpg?t=st=1658624732~exp=1658625332~hmac=e13be5cfc557d01f25763770f510d1675a2e0084d51db917e8476745bc6141f5&w=2000',
                    //         ),
                    //         fit: BoxFit.cover,
                    //         height: 200.0,
                    //         width: double.infinity,
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.all(8.0),
                    //         child: Text(
                    //           textAlign: TextAlign.center,
                    //           'communicate with \nfriends',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 20,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                        SocialCubit.get(context).posts[index],
                        context,
                        index,
                      ),
                      itemCount: SocialCubit.get(context).posts.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
          fallback: ((context) => Center(child: CircularProgressIndicator())),
        );
      }),
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // CircleAvatar(
                  //   radius: 25.0,
                  //   backgroundImage: NetworkImage(model.image!),
                  // ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      if (model.name !=
                          SocialCubit.get(context).userModel!.name)
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: storyColor,
                            ),
                          ),
                        ),
                      CircleAvatar(
                        radius: 26,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 23,
                          backgroundImage: NetworkImage(
                            model.image!,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 17,
                                    height: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),

                              // style: TextStyle(
                              //   color:
                              //       Theme.of(context).scaffoldBackgroundColor ==
                              //               Colors.white
                              //           ? Colors.black
                              //           : Colors.white,
                              //   height: 1.5,
                              //   fontWeight: FontWeight.bold,
                              // ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            if (model.name == 'vinijr' ||
                                model.name == 'karimbenzema')
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 15,
                              )
                          ],
                        ),
                        Text(
                          model.dateTime!,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    height: 1.5,
                                    fontSize: 12,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 15.0,
              //   ),
              //   child: Container(
              //     width: double.infinity,
              //     height: 1.0,
              //     color: Colors.grey[300],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 5,
              //   ),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#developer',
              //                 style: TextStyle(
              //                   fontSize: 13,
              //                   color: defaultColor,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#mobile_developer',
              //                 style: TextStyle(
              //                   fontSize: 13,
              //                   color: defaultColor,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#ios_developer',
              //                 style: TextStyle(
              //                   fontSize: 13,
              //                   color: defaultColor,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#software_development',
              //                 style: TextStyle(
              //                   fontSize: 13,
              //                   color: defaultColor,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 10.0,
                  ),
                  child: Container(
                    height: 400.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          model.postImage!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 7.0,
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: InkWell(
              //           onTap: () {},
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(
              //               vertical: 5.0,
              //             ),
              //             child: Row(
              //               children: [
              //                 Icon(
              //                   IconBroken.Heart,
              //                   color: Colors.pink,
              //                   size: 20,
              //                 ),
              //                 SizedBox(
              //                   width: 5,
              //                 ),
              //                 Text(
              //                   '${SocialCubit.get(context).likes[index] + 20}',
              //                   style: Theme.of(context).textTheme.caption,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: InkWell(
              //           onTap: () {},
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(
              //               vertical: 5.0,
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: [
              //                 Icon(
              //                   IconBroken.Chat,
              //                   color: Colors.amber,
              //                   size: 20,
              //                 ),
              //                 SizedBox(
              //                   width: 5,
              //                 ),
              //                 Text(
              //                   '${SocialCubit.get(context).comments[index] + 11} comments',
              //                   style: Theme.of(context).textTheme.caption,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 10.0,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     bottom: 15.0,
              //   ),
              //   child: Container(
              //     width: double.infinity,
              //     height: 1.0,
              //     color: Colors.grey[300],
              //   ),
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(
                        SocialCubit.get(context).postsId[index],
                      );
                    },
                    child: LikeButton(
                      isLiked: false,
                      likeBuilder: (isLiked) {
                        return isLiked
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30.0,
                              )
                            : Icon(
                                IconBroken.Heart,
                                size: 30.0,
                              );
                      },
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: defaultColor,
                        dotSecondaryColor: Colors.yellowAccent,
                      ),
                      likeCount: SocialCubit.get(context).likes[index] + 1998,
                      likeCountPadding: EdgeInsets.only(
                        top: 10.0,
                      ),
                      countPostion: CountPostion.bottom,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .commentPost(SocialCubit.get(context).postsId[index]);
                    },
                    child: Icon(
                      IconBroken.Chat,
                      size: 30.0,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    IconBroken.Send,
                    size: 30.0,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  Spacer(),
                  Icon(
                    Icons.bookmark_outline_rounded,
                    size: 30.0,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10.0,
              // ),
              // Text(
              //   '${likeCount} ',
              //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //         fontSize: 16,
              //         height: 1.3,
              //         fontWeight: FontWeight.w500,
              //       ),
              //   // style: TextStyle(
              //   //   fontSize: 16.0,
              //   //   height: 1.3,
              //   //   fontWeight: FontWeight.w500,
              //   //   color:
              //   //       Theme.of(context).scaffoldBackgroundColor == Colors.white
              //   //           ? Colors.black
              //   //           : Colors.white,
              //   // ),
              // ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model.name!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          height: 1.3,
                          fontWeight: FontWeight.w500,
                        ),
                    // style: TextStyle(
                    //   fontSize: 16.0,
                    //   height: 1.3,
                    //   fontWeight: FontWeight.w500,
                    //   color: Theme.of(context).scaffoldBackgroundColor ==
                    //           Colors.white
                    //       ? Colors.black
                    //       : Colors.white,
                    // ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      '${model.text}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            height: 1.5,
                            fontSize: 15,
                          ),
                      // style: TextStyle(
                      //   fontSize: 16.0,
                      //   height: 1.3,
                      //   fontWeight: FontWeight.w400,
                      //   color: Theme.of(context).scaffoldBackgroundColor ==
                      //           Colors.white
                      //       ? Colors.black
                      //       : Colors.white,
                      // ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).commentPost(
                            SocialCubit.get(context).postsId[index]);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 17.0,
                            backgroundImage: NetworkImage(
                              SocialCubit.get(context).userModel!.image!,
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'write a comment ...',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Text(
                          '😂',
                          style: TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          '🇩🇿',
                          style: TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildStoryItem(
      context, socialUserModel model, socialUserModel? usermodel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                if (model.story == true)
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: storyColor,
                      ),
                    ),
                  ),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(
                      model.image!,
                    ),
                  ),
                ),
              ],
            ),
            if (model.name == usermodel?.name)
              CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                radius: 11.5,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: usermodel?.name == model.name ? 5 : 5,
        ),
        Container(
          padding: EdgeInsetsDirectional.only(start: 4),
          alignment: Alignment.bottomCenter,
          width: 80.0,
          child: Text(
            model.name!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
