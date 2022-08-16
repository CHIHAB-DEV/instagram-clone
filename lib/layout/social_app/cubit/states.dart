abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLaodingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

// create post

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

// get post data

class SocialGetPostsLaodingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

// like post

class SocialLikePostsLaodingState extends SocialStates {}

class SocialLikePostsSuccessState extends SocialStates {}

class SocialLikePostsErrorState extends SocialStates {
  final String error;

  SocialLikePostsErrorState(this.error);
}

class SocialGetLikesPostsLaodingState extends SocialStates {}

class SocialGetLikesPostsSuccessState extends SocialStates {}

class SocialGetLikesPostsErrorState extends SocialStates {
  final String error;

  SocialGetLikesPostsErrorState(this.error);
}

// Comment post

class SocialCommentPostsLaodingState extends SocialStates {}

class SocialCommentPostsSuccessState extends SocialStates {}

class SocialCommentPostsErrorState extends SocialStates {
  final String error;

  SocialCommentPostsErrorState(this.error);
}

class SocialGetCommentPostsLaodingState extends SocialStates {}

class SocialGetCommentPostsSuccessState extends SocialStates {}

class SocialGetCommentPostsErrorState extends SocialStates {
  final String error;

  SocialGetCommentPostsErrorState(this.error);
}

// get all users

class SocialGetALLUserLaodingState extends SocialStates {}

class SocialGetALLUserSuccessState extends SocialStates {}

class SocialGetALLUserErrorState extends SocialStates {
  final String error;

  SocialGetALLUserErrorState(this.error);
}

//CHATS

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {
  final String error;

  SocialSendMessageErrorState(this.error);
}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetLastMessageSuccessState extends SocialStates {}

class SocialChangeThemeSuccessState extends SocialStates {}

//chat image
class SocialChatImagePickedSuccessState extends SocialStates {}

class SocialChatImagePickedErrorState extends SocialStates {}

class SocialRemoveChatImageState extends SocialStates {}

class SocialCreateChatLoadingState extends SocialStates {}

class SocialSendImageMessageLoadingState extends SocialStates {}

class SocialSendImageMessageSuccessState extends SocialStates {}

class SocialSendImageMessageErrorState extends SocialStates {
  final String error;

  SocialSendImageMessageErrorState(this.error);
}

class SocialGetImageMessageSuccessState extends SocialStates {}

class SocialGetLastImageMessageSuccessState extends SocialStates {}
