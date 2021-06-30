class TeacherAssignment{
  var assignCode , totalGrade ,studentMark , isConfirmed ,assignmentStudentCode ,type;
  String chapterNameEN,chapterNameAR,lessonNameAR,lessonNameEN,filePath ,assignmentName,publishDate,publishTime;

  TeacherAssignment({
    this.totalGrade,
    this.studentMark,
    this.lessonNameAR,
    this.chapterNameEN,
    this.chapterNameAR,
    this.filePath,
    this.assignCode,
    this.assignmentStudentCode,
    this.isConfirmed,
    this.lessonNameEN,
    this.type,
    this.assignmentName,
    this.publishDate,
    this.publishTime
});
  factory TeacherAssignment.fromJson(Map<String, dynamic> json){
    return TeacherAssignment(
      studentMark: json['student_assignment_mark'],
      totalGrade: json['total_grade'],
      publishDate: json['publish_date'],
      chapterNameEN: json['chapter_name_en'],
      chapterNameAR: json['chapter_name_ar'],
      lessonNameAR: json['lesson_name_ar'],
      type: json['type'],
      filePath: json['file_path'],
      assignmentName: json['assignment_name'],
      publishTime: json['publish_time'],
      assignCode: json['assignment_code'],
      assignmentStudentCode: json['assignment_student_code'],
      isConfirmed: json['is_confirm'],
      lessonNameEN: json['lesson_name_en'],
    );}
}