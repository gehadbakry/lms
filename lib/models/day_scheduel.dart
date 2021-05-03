class DayScheduel{
  int courseNoCode;
  String startTime;
  String endTime;
  String subjectNameEn;
  String subjectNameAr;
  int dayCode;
  String dayNameAr;
  String dayNameEn;
  String teacherNameAr;
  String teacherNameEn;

  DayScheduel({
    this.dayCode,
    this.dayNameEn,
    this.dayNameAr,
    this.teacherNameEn,
    this.teacherNameAr,
    this.subjectNameEn,
    this.subjectNameAr,
    this.courseNoCode,
    this.endTime,
    this.startTime,
});

  factory DayScheduel.fromJson(Map<String, dynamic> json){
    return DayScheduel(
      dayNameEn: json['day_name_en'],
      dayNameAr: json['day_name_ar'],
      dayCode: json['day_code'],
      subjectNameEn: json['subject_name_en'],
      subjectNameAr: json['subject_name_ar'],
      teacherNameEn: json['teacherNameEn'],
      teacherNameAr: json['teacherNameAr'],
      courseNoCode: json['course_no_code'],
      endTime: json['course_end_time'],
      startTime: json['course_start_time'],
    );
  }
}