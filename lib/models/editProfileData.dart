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
      'user_code':userCode == null?'':userCode,
      'password':password == null?'':password,
      'facebook_url':facebookUrl == null?'':facebookUrl,
      'twitter_url':twitterUrl == null?'':twitterUrl,
      'instagram_url':instgramUrl == null?'':instgramUrl,
      'linkin_url':linkedinUrl == null?'':linkedinUrl,
      'file':file == null?'':file,
         };

    return map;
  }
}