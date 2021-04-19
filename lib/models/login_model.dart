class LoginResponseModel {
  String userType;
  String userCode;
  String code;
  String childrenCode;
  String imagepath;
  int schoolYearCode;
  String facebook;
  String twitter;
  String instgram;
  String linkedIn;
  String pass;
  String CoPass;

  LoginResponseModel({this.userCode,
    this.childrenCode,
    this.code,
    this.userType,
    this.imagepath,
    this.schoolYearCode,
    this.facebook,
    this.twitter,
    this.instgram,
    this.linkedIn,
    this.pass,
    this.CoPass,
  });

  Map<String, dynamic> Json() {
    Map<String, dynamic> map = {
      'user_type_code': userType,
      'user_code': userCode,
      'children_code': childrenCode,
      'code': code,
      'img_path': imagepath,
      'schooling_year_code': schoolYearCode,
      'facebook_url': facebook,
      'twitter_url': twitter,
      'instagram_url': instgram,
      'linked_url': linkedIn,
      'password': pass,
      'ConfirmPassword': CoPass,

    };

    return map;
  }

  factory LoginResponseModel.fromJson(Map<String, dynamic>json){
    return LoginResponseModel(
      code:json['code'],
      childrenCode:json['children_code'],
      userCode: json['user_code'],
      userType: json['user_type_code'],
      linkedIn: json['linked_url'],
      instgram: json['instagram_url'],
      twitter: json['twitter_url'],
      facebook: json['facebook_url'],
      CoPass: json['ConfirmPassword'],
      imagepath: json[ 'img_path'],
      pass: json['password'],
      schoolYearCode: json['schooling_year_code'],
    );
  }

}

class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'userName': username.trim(),
      'password': password.trim(),
    };

    return map;
  }
}