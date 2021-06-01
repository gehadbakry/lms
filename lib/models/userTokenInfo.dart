class UserToken{
  String userCode;
  String userToken;
  String language;

  UserToken({
    this.userCode,
    this.userToken,
    this.language,
});


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'userCode': userCode,
      'userTockenIDStr': userToken,
      'languageCode': language,
    };

    return map;
  }
}