class TeacherScheduel{
  int courseCode,dayCode,schoolCourseCode;
  String courseStart,courseEnd,subjectNameAR,subjectNameEN,
  dayNameAR,dayNameEn,teacherNameAR,teacherNameEn,classNameAR,classNameEN,stageNameAr,stageNameEn;

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
    this.classNameAR,
    this.classNameEN,
    this.schoolCourseCode,
    this.stageNameAr,
    this.stageNameEn,
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
      classNameAR: json['school_class_name_ar'],
      classNameEN: json['school_class_name_en'],
      schoolCourseCode: json['school_courses_table_setup_stages_details_code'],
      stageNameAr: json['stage_name_ar'],
      stageNameEn: json['stage_name_en'],
    );}
}
