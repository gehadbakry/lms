class User{
  String sNameAR;
  String sNameEN;
  String stageNameAR;
  String stageNameEN;
  String classNameAR;
  String classNameEN;
  String learningPhaseAR;
  String learningPhaseEN;
  String imagePath;
  int userCode;
  int studentCode;
  String facebook;
  String twitter;
  String instgram;
  String linkedIn;
  int schoolYear;

  User({this.sNameAR,
    this.sNameEN,
    this.stageNameAR,
    this.stageNameEN,
    this.classNameAR,
    this.classNameEN,
    this.learningPhaseAR,
    this.learningPhaseEN,
    this.imagePath,
    this.userCode,
    this.studentCode,
    this.facebook,
    this.twitter,
    this.instgram,
    this.linkedIn,
    this.schoolYear,
  });

  factory User.fromJson(Map<String,dynamic>json){
    return User(
      sNameAR: json['student_full_name_ar'],
      sNameEN: json['student_full_name_en'],
      stageNameAR: json['stage_name_ar'],
      stageNameEN: json['stage_name_en'],
      classNameAR: json['school_class_name_ar'],
      classNameEN: json['school_class_name_en'],
      learningPhaseAR: json['learning_phase_name'],
      learningPhaseEN: json['learning_phase_name_en'],
      imagePath: json['img_path'],
      userCode: json['user_code'],
      studentCode: json['student_code'],
      facebook: json['facebook_url'],
      twitter: json['twitter_url'],
      instgram: json['nstagram_url'],
      linkedIn: json['linked_url'],
      schoolYear: json['schooling_year_code']
    );
  }

}

// class User {
//   int Id;
//   int UserName;
//   String title;
//   User({this.Id,this.UserName,this.title});
//   factory User.fromJson(Map<String,dynamic>json){
//    return User(Id:json['id '],
//    UserName: json['userId'],
//      title: json['title']
//    );
//   }
// }