import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/layout/social_app/cubit/cubit.dart';
import 'package:social_media_app/layout/social_app/cubit/states.dart';
import 'package:social_media_app/models/social_user_model.dart';
import 'package:social_media_app/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:social_media_app/shared/componants.dart';
import 'package:social_media_app/shared/styles/icon_broken.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildChatItem(
                context,
                SocialCubit.get(context).users[index],
                SocialCubit.get(context).userModel,
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              );
            },
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(
      context, socialUserModel model, socialUserModel? usermodel) {
    if (model.name != usermodel?.name) {
      return InkWell(
        onTap: () {
          navigatorTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 27.0,
                backgroundImage: NetworkImage(model.image!),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        model.name!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.name == 'lukamodric10' ||
                          model.name == 'riyadmahrez26.7' ||
                          model.name == 'vinijr' ||
                          model.name == 'cristiano' ||
                          model.name == 'karimbenzema')
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 15,
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'tap to open chat with ${model.name}',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 14.0),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Camera,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
