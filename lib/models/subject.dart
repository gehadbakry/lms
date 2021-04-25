
class Subject{
String subjectNameAr;
String subjectNameEn;
int termCode;
String termNameAr;
String termNameEn;
int subjectCode;
String imgPath;
String teacherNameAr;
String teacherNameEn;
String teacherImg;
int numberChapters;

Subject({
  this.imgPath,
  this.numberChapters,
this.subjectCode,
this.subjectNameAr,
this.subjectNameEn,
this.teacherImg,
this.teacherNameAr,
this.teacherNameEn,
this.termCode,
this.termNameAr,
this.termNameEn,
});
factory Subject.fromJson(Map<String, dynamic> json){
  return Subject(
    imgPath: json['img_path'],
    numberChapters: json['NoOfChapters'],
    subjectCode: json['stage_subject_code'],
    subjectNameAr: json['subject_name_ar'],
    subjectNameEn: json['subject_name_en'],
    teacherImg: json['teacherImg'],
    teacherNameAr: json['teacherNameAr'],
    teacherNameEn: json['teacherNameEn'],
    termCode: json['term_code'],
    termNameAr: json['term_name_ar'],
    termNameEn: json['term_name_en'],
  );
}
}