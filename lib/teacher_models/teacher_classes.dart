class TeacherClasses{
  int classCode;
  String classNameAR,classNameEn;
  TeacherClasses({
    this.classCode,
    this.classNameAR,
    this.classNameEn
});
  factory TeacherClasses.fromJson(Map<String, dynamic> json){
    return TeacherClasses(
      classCode: json['school_class_code'],
      classNameEn:json['school_class_name_en'],
      classNameAR:json['school_class_name_ar']
    );
  }
}