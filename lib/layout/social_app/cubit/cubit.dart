import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:social_media_app/layout/social_app/cubit/states.dart';
import 'package:social_media_app/models/message_model.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/models/social_user_model.dart';
import 'package:social_media_app/modules/social_app/chats/chats_screen.dart';
import 'package:social_media_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:social_media_app/modules/social_app/new_post/new_post_screen.dart';
import 'package:social_media_app/modules/social_app/settings/setings_screen.dart';
import 'package:social_media_app/shared/componants.dart';
import 'package:social_media_app/shared/constans.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_media_app/shared/network/local/cashe_helper.dart';

import '../../../modules/social_app/shop/shop_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  socialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLaodingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = socialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int? currentIndex = 0;

  List<Widget> screeens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    ShopScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Instagram 🇩🇿',
    'Chat',
    'post',
    'Shop',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getUsers();

    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  // UPLOAD PROFILE AND COVER IMAGE

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print('success profile image ');

      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      print('error profile image ');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print('success cover image ');

      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      print('error cover image ');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(profileImage!.path).pathSegments.last}',
        )
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('value is ${value}');
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        print('error get value ${error.toString()}');
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print('error upload photo ${error.toString()}');
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('cover value is ${value}');
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        print('error get cover value ${error.toString()}');
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print('error upload cover photo ${error.toString()}');
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImage({
  //   required String? name,
  //   required String? phone,
  //   required String? bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  // EDIT PROFILE

  void updateUser({
    required String? name,
    required String? phone,
    required String? bio,
    String? cover,
    String? image,
  }) {
    socialUserModel model = socialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      isEmailVirified: false,
      email: userModel!.email,
      uId: userModel!.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print('error user update ${error.toString()}');
      emit(SocialUserUpdateErrorState());
    });
  }

  // NEW POST CUBIT

  File? postImage;

  Future<void> getpostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print('success post image ');

      emit(SocialPostImagePickedSuccessState());
    } else {
      print('error post image ');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    print('SocialRemovePostImageState');
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String? dateTime,
    required String? text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('cover value is ${value}');
        createPost(
          postImage: value,
          dateTime: dateTime,
          text: text,
        );
      }).catchError((error) {
        print('error get cover value ${error.toString()}');
        emit(SocialCreatePostSuccessState());
      });
    }).catchError((error) {
      print('error upload cover photo ${error.toString()}');
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      print('SocialCreatePostSuccessState');
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print('error user update ${error.toString()}');
      emit(SocialCreatePostErrorState());
    });
  }

  // get posts data

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  List<bool> isLiked = [];
  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy("dateTime")
        .get()
        .then((value) async {
      for (var element in value.docs) {
        await element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          print('SocialGetCommentPostsLaodingState');
          emit(SocialGetCommentPostsLaodingState());
        }).catchError((error) {
          print('SocialGetCommentPostsErrorState');
          emit(SocialGetCommentPostsErrorState(error.toString()));
        });
        await element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          print('SocialGetLikesPostsSuccessState');
          emit(SocialGetLikesPostsSuccessState());
        }).catchError((error) {
          print('SocialGetLikesPostsErrorState ');
          emit(SocialGetLikesPostsErrorState(error.toString()));
        });
      }

      print('SocialGetPostsSuccessState');
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print('SocialGetPostsErrorState');
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  // like post

  void likePost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      print('Like Posts Success');
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      print('SocialLikePostsErrorState');
      emit(SocialLikePostsErrorState(error.toString()));
    });
  }

  //like post
  // Future<void> likePost({
  //   required int postIndex,
  // }) async {
  //   String postId = posts[postIndex].postId;
  //   bool isLiked = posts[postIndex].likes.contains(userModel!.uId);

  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection('likes')
  //       .doc(userModel!.uId)
  //       .set({
  //     'like': !isLiked,
  //   }).then((_) {
  //     if (isLiked) {
  //       posts[postIndex].likes.remove(userModel!.uId);
  //     } else {
  //       posts[postIndex].likes.add(userModel!.uId);
  //     }

  //     emit(SocialLikePostSuccessState());
  //   }).catchError((error) {
  //     log('error when likePost: ${error.toString()}');
  //     emit(SocialLikePostErrorState(error.toString()));
  //   });
  // }

  // comments post

  void commentPost(String? postId) {
    print('loading comments');
    emit(SocialCommentPostsLaodingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      'comments': true,
    }).then((value) {
      print('SocialCommentPostsSuccessState');
      emit(SocialCommentPostsSuccessState());
    }).catchError((error) {
      print('SocialCommentPostsErrorState');
      emit(SocialCommentPostsErrorState(error.toString()));
    });
  }

  // GET ALL USERS
  List<socialUserModel> users = [];

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          // if (element.data()['uId'] != userModel!.uId) {
          users.add(socialUserModel.fromJson(element.data()));
          // }
        }
        print('objeSocialGetALLUserSuccessState');
        emit(SocialGetALLUserSuccessState());
      }).catchError((error) {
        print('🛑SocialGetALLUserErrorState:🛑 ${error.toString()}');
        emit(SocialGetALLUserErrorState(error.toString()));
      });
    }
  }

  //Chats
  void sendMessage({
    required String? reciverId,
    required String? dateTime,
    required String? text,
  }) {
    messageModel model = messageModel(
      text: text,
      receverId: reciverId,
      dateTime: dateTime,
      senderId: userModel!.uId,
    );

    // set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(model.toMap())
        .then(
      (value) {
        print(SocialSendMessageSuccessState);

        emit(SocialSendMessageSuccessState());
        emit(SocialGetMessageSuccessState());
      },
    ).catchError(
      (error) {
        print(SocialSendMessageErrorState);

        emit(SocialSendMessageErrorState(error.toString()));
      },
    );
    // set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then(
      (value) {
        print(SocialSendMessageSuccessState);
        emit(SocialSendMessageSuccessState());
      },
    ).catchError(
      (error) {
        print(SocialSendMessageErrorState);
        emit(SocialSendMessageErrorState(error.toString()));
      },
    );
  }

  List<messageModel> messages = [];

  void getMessages({
    required String? reciverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(messageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  bool isDark = false;
  IconData? themeIcon = Icons.brightness_4_outlined;

  void changeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      print('✅Change   Theme✅');

      emit(SocialChangeThemeSuccessState());
    } else {
      isDark = !isDark;
      themeIcon = isDark == true
          ? Icons.brightness_4_rounded
          : Icons.brightness_4_outlined;
      CasheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        print('✅ChangeTheme✅');
        emit(SocialChangeThemeSuccessState());
      });
    }
  }

  //Chat send image

  File? chatImage;

  Future<void> getImageMessage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      print('success Chat image ');

      emit(SocialChatImagePickedSuccessState());
    } else {
      print('error Chat image ');
      emit(SocialChatImagePickedErrorState());
    }
  }

  void uploadImageMessage({
    required String? dateTime,
    required String? reciverId,
  }) {
    emit(SocialSendImageMessageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/${userModel!.uId}/chats/${userModel!.uId}/messages/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendImageMessage(
          reciverId: reciverId,
          dateTime: dateTime,
          chatImage: value,
        );
      }).catchError((error) {});
    }).catchError((error) {});
  }

  void sendImageMessage({
    required String? reciverId,
    required String? dateTime,
    required String? chatImage,
  }) {
    messageModel model = messageModel(
      imageUrl: chatImage,
      receverId: reciverId,
      dateTime: dateTime,
      senderId: userModel!.uId,
    );

    emit(SocialSendImageMessageLoadingState());

    // set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(model.toMap())
        .then(
      (value) {
        print('SocialSend image SuccessState');

        emit(SocialSendImageMessageSuccessState());
      },
    ).catchError(
      (error) {
        print('send image chat error');

        emit(SocialSendImageMessageErrorState(error.toString()));
      },
    );
    // set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then(
      (value) {
        print(SocialSendImageMessageSuccessState);
        emit(SocialSendImageMessageSuccessState());
      },
    ).catchError(
      (error) {
        print(SocialSendImageMessageErrorState);
        emit(SocialSendImageMessageErrorState(error.toString()));
      },
    );
  }

  // List<messageModel> ImageMessages = [];

  // void getImageMessages({
  //   required String? reciverId,
  // }) {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userModel!.uId)
  //       .collection('chats')
  //       .doc(reciverId)
  //       .collection('chatImage')
  //       .orderBy('dateTime')
  //       .snapshots()
  //       .listen((event) {
  //     ImageMessages = [];
  //     event.docs.forEach((element) {
  //       ImageMessages.add(messageModel.fromJson(element.data()));
  //     });
  //     emit(SocialGetMessageSuccessState());
  //   });
  // }
}
