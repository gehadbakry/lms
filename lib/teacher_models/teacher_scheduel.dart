class TeacherScheduel{
  int courseCode,dayCode;
  String courseStart,courseEnd,subjectNameAR,subjectNameEN,
  dayNameAR,dayNameEn,teacherNameAR,teacherNameEn;

  TeacherScheduel({
    this.dayCode,
    this.dayNameAR,
    this.dayNameEn,
    this.teacherNameAR,
    this.teacherNameEn,
    this.subjectNameAR,
    this.courseCode,
    this.courseEnd,
    this.courseStart,
    this.subjectNameEN,
});
  factory TeacherScheduel.fromJson(Map<String, dynamic> json){
    return TeacherScheduel(
      dayCode: json['day_code'],
      dayNameAR: json['day_name_ar'],
      teacherNameAR: json['teacherNameAr'],
      teacherNameEn: json['teacherNameEn'],
      subjectNameAR: json['subject_name_ar'],
      dayNameEn: json['day_name_en'],
      courseCode: json['course_no_code'],
      courseEnd: json['course_end_time'],
      courseStart: json['course_start_time'],
      subjectNameEN: json['subject_name_en'],
    );}
}