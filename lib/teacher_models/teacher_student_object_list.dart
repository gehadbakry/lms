class StudentInList{
  String nameAR ,nameEN;
  int schoolClassCode;
  var behavior;

  StudentInList({
    this.nameAR,
    this.nameEN,
    this.behavior,
    this.schoolClassCode
});
  factory StudentInList.fromJson(Map<String, dynamic> json){
    return StudentInList(
      behavior: json['behaviour'],
      nameAR: json['student_full_name_ar'],
      nameEN: json['student_full_name_en'],
      schoolClassCode: json['school_class_code'],
    );
  }
}