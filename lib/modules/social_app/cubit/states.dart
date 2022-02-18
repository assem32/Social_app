abstract class SocialLoginStates{}

class SocialInitialLoginState extends SocialLoginStates{}

class SocialSuccessLoginState extends SocialLoginStates{
  final String uId;
  SocialSuccessLoginState(this.uId);
}

class SocialErrorLoginState extends SocialLoginStates{
  final String error;
  SocialErrorLoginState(this.error);
}

class SocialLoadingLoginState extends SocialLoginStates{}

class SocialSuffixState extends SocialLoginStates{}


