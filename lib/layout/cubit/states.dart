abstract class SocialState{}

class SocialInitialize extends SocialState{}

class SocialLoading extends SocialState{}

class SocialSuccess extends SocialState{}

class SocialError extends SocialState{
  final String error;
  SocialError(this.error);
}

class SocialNav extends SocialState{}

class SocialAddPost extends SocialState{}

//photo states

class SocialProfileImagePickSuccessPost extends SocialState{}

class SocialProfileImagePickErrorState extends SocialState{}

class SocialProfileCoverPickSuccessState extends SocialState{}

class SocialProfileCoverPickErrorState extends SocialState{}

class SocialProfileUploadSuccessState extends SocialState{}

class SocialProfileUploadErrorState extends SocialState{}

class SocialProfileCoverUploadSuccessState extends SocialState{}

class SocialProfileCoverUploadErrorState extends SocialState{}

class SocialUpdateSuccessUserState extends SocialState{}

class SocialUpdateLoadingUserState extends SocialState{}

//create post

class SocialCreatePostSuccessState extends SocialState{}

class SocialCreatePostErrorState extends SocialState{}

class SocialImagePostPickSuccessState extends SocialState{}

class SocialImagePostPickErrorState extends SocialState{}

class SocialCreatePostLoadingState extends SocialState{}

class SocialRemovePostPhotoState extends SocialState{}

//posts

class GetUserPostLoadingState extends SocialState{}

class GetUserPostSuccessState extends SocialState{}

class GetUserPostErrorState extends SocialState{
  final String error;
  GetUserPostErrorState(this.error);
}

//likes

class SocialLikePostSuccess extends SocialState{}

class SocialLikePostError extends SocialState{
  final String error;
  SocialLikePostError(this.error);
}

//comments

class SocialCommentPostSuccess extends SocialState{}

class SocialCommentPostError extends SocialState{
  final String error;
  SocialCommentPostError(this.error);
}

//chats

class GetUsersChatLoadingState extends SocialState{}

class GetUsersChatSuccessState extends SocialState{}

class GetUsersChatErrorState extends SocialState{
  final String error;
  GetUsersChatErrorState(this.error);
}

//message

class SendMassageSuccessState extends SocialState{}

class SendMassageErrorState extends SocialState{}

class GetMassageSuccessState extends SocialState{}

