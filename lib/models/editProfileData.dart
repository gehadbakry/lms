class EditProfile{
  String userCode , password ,facebookUrl ,twitterUrl ,instgramUrl, linkedinUrl,file;

  EditProfile({
    this.userCode,
    this.password,
    this.facebookUrl,
    this.twitterUrl,
    this.instgramUrl,
    this.linkedinUrl,
    this.file,
});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_code':userCode == null?'':userCode.trim(),
      'password':password == null?'':password.trim(),
      'facebook_url':facebookUrl == null?'':facebookUrl.trim(),
      'twitter_url':twitterUrl == null?'':twitterUrl.trim(),
      'instagram_url':instgramUrl == null?'':instgramUrl.trim(),
      'linkin_url':linkedinUrl == null?'':linkedinUrl.trim(),
      'file':file == null?'':file,
         };

    return map;
  }
}