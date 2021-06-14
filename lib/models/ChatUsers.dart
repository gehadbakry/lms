class ChatUsers{
  int teacherCode,userCode;
  String teacherNameAE;
  String teacherNameEn;
  String subjectNameEn;
  String subjectNameAr;

ChatUsers({
    this.teacherNameEn,
    this.teacherNameAE,
  this.subjectNameEn,
  this.userCode,
  this.teacherCode,
  this.subjectNameAr,
});

  factory ChatUsers.fromJson(Map<String, dynamic> json){
    return ChatUsers(
      userCode: json['user_code'],
      teacherNameEn: json['teacher_full_name_en'],
      teacherNameAE: json['teacher_full_name_ar'],
      subjectNameEn: json['subject_name_en'],
      subjectNameAr: json['subject_name_ar'],
      teacherCode: json['teacher_code'],

    );
  }
}