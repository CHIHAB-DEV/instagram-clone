import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/layout/social_app/cubit/cubit.dart';
import 'package:social_media_app/layout/social_app/cubit/states.dart';
import 'package:social_media_app/models/message_model.dart';
import 'package:social_media_app/models/social_user_model.dart';
import 'package:social_media_app/shared/componants.dart';
import 'package:social_media_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  socialUserModel userModel;

  ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);

  var messageController = TextEditingController();
  ScrollController? scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(reciverId: userModel.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(
                        userModel.image!,
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel.name!,
                      style: const TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconBroken.Call,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconBroken.Video,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     IconBroken.Info_Circle,
                  //   ),
                  // ),
                ],
              ),
              body: ConditionalBuilder(
                condition: (state is SocialGetMessageSuccessState ||
                    // SocialCubit.get(context).ImageMessages.isNotEmpty ||
                    SocialCubit.get(context).messages.isNotEmpty),
                // condition: SocialCubit.get(context).messages.isNotEmpty,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];
                              if (message.text != null) {
                                if (SocialCubit.get(context).userModel!.uId ==
                                    message.senderId) {
                                  return buildMyMessage(message, context);
                                } else {
                                  return buildMessage(message, context);
                                }
                              }

                              if (message.imageUrl != null) {
                                if (SocialCubit.get(context).userModel!.uId ==
                                    message.senderId) {
                                  return buildMyImageMessage(message, context);
                                } else {
                                  return buildImageMessage(message, context);
                                }
                              }
                              return SizedBox();
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15.0,
                            ),
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              // color: Colors.grey[300],
                              color: const Color(0xFFE0E0E0),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    50,
                                  ),
                                  color: Colors.blue[400],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getImageMessage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Message...',
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17.0,
                                      ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (messageController.text != '') {
                                    SocialCubit.get(context).sendMessage(
                                      reciverId: userModel.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );
                                  } else {
                                    print('text chat null');
                                  }
                                  if (SocialCubit.get(context).chatImage !=
                                      null) {
                                    SocialCubit.get(context).uploadImageMessage(
                                        reciverId: userModel.uId,
                                        dateTime: DateTime.now().toString());
                                  } else {
                                    print('chat image null');
                                  }

                                  messageController.text = '';
                                  SocialCubit.get(context).chatImage = null;

                                  FocusManager.instance.primaryFocus?.unfocus();
                                  scrollController!.animateTo(
                                    scrollController!.position.maxScrollExtent,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.easeOut,
                                  );
                                },
                                icon: state
                                        is SocialSendImageMessageLoadingState
                                    ? const CircularProgressIndicator()
                                    : Icon(
                                        IconBroken.Send,
                                        size: 25.0,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                              ),
                              // if (SocialCubit.get(context).chatImage != null)
                              //   Icon(Icons.photo),
                              IconButton(
                                onPressed: () {
                                  messageController.text = '❤️';

                                  SocialCubit.get(context).sendMessage(
                                    reciverId: userModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                  messageController.text = '';

                                  FocusManager.instance.primaryFocus?.unfocus();
                                  scrollController!.animateTo(
                                    scrollController!.position.maxScrollExtent,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.easeOut,
                                  );
                                },
                                icon: Icon(
                                  IconBroken.Heart,
                                  size: 25.0,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  );
                },
                fallback: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMyMessage(messageModel model, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          // height: 100,
          // width: 100,
          decoration: BoxDecoration(
            color: Colors.cyan[400],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
            ),
          ),
          child: Text(
            '${model.text}',
            style: TextStyle(
              fontSize: 17.0,
              color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      );

  Widget buildMyImageMessage(messageModel model, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          height: 250,
          width: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(30),
              topEnd: Radius.circular(30),
              bottomStart: Radius.circular(30),
            ),
          ),
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(model.imageUrl!),
          ),
        ),
      );

  Widget buildMessage(messageModel model, context) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          // height: 100,
          // width: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                ? Colors.white
                : Colors.black,
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
          ),
          child: Text(
            '${model.text}',
            style: TextStyle(
              fontSize: 17.0,
              color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      );

  Widget buildImageMessage(messageModel model, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                ? Colors.white
                : Colors.black,
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(30),
              topEnd: Radius.circular(30),
              bottomEnd: Radius.circular(30),
            ),
          ),
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(model.imageUrl!),
          ),
        ),
      );
}
