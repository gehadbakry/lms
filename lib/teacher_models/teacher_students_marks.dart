class StudentsMarksList{
  String nameAR,nameEN;
  var mark;
  int classCode ,quizCode,studentCode;

  StudentsMarksList({
    this.nameEN,
    this.nameAR,
    this.classCode,
    this.quizCode,
    this.studentCode,
    this.mark,
});
  factory StudentsMarksList.fromJson(Map<String, dynamic> json){
    return StudentsMarksList(
      nameEN: json['student_full_name_en'],
      nameAR: json['student_full_name_ar'],
      classCode: json['class_code'],
      quizCode: json['quize_code'],
      studentCode: json['student_code'],
      mark: json['student_mark'],
    );
  }
}