class Student{
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

  Student({this.sNameAR,
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

  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> map = {
  //     'student_full_name_ar':sNameAR == null ? null :sNameAR,
  //     'student_full_name_en':sNameEN,
  //     'stage_name_ar':stageNameAR,
  //     'stage_name_en':stageNameEN,
  //     'school_class_name_ar':classNameAR,
  //     'school_class_name_en':classNameEN,
  //     'learning_phase_name':learningPhaseAR,
  //     'learning_phase_name_en':learningPhaseEN,
  //     'img_path':imagePath,
  //     'user_code':userCode,
  //     'student_code':studentCode,
  //     'facebook_url':facebook,
  //     'twitter_url':twitter,
  //     'instagram_url':instgram,
  //   'linked_url':linkedIn,
  //     'schooling_year_code':schoolYear,
  //   };
  //   return map;
  // }

  factory Student.fromJson(Map<String, dynamic> json){
    return Student(
      sNameAR: json['student_full_name_ar'] as String,
      sNameEN: json['student_full_name_en'] as String,
      stageNameAR: json['stage_name_ar'] as String,
      stageNameEN: json['stage_name_en'] as String,
      classNameAR: json['school_class_name_ar'] as String,
      classNameEN: json['school_class_name_en'] as String,
      learningPhaseAR: json['learning_phase_name'] as String,
      learningPhaseEN: json['learning_phase_name_en'] as String,
      imagePath: json['img_path'] as String,
      userCode: json['user_code'] as int,
      studentCode: json['student_code'] as int,
      facebook: json['facebook_url'] as String,
      twitter: json['twitter_url'] as String,
      instgram: json['instagram_url'] as String,
      linkedIn: json['linked_url'] as String,
      schoolYear: json['schooling_year_code'] as int,
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