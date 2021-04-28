class Assignment {
  int assignmentCode;
  String assignmentName;
  int totalGrade;
  String publishDate;
  String publishTime;
  double assignmentMark;
  String chapterNameAr;
  String chapterNameEn;
  String lessonNameAr;
  String lessonNameEn;
  String filePath;
  int type;

  Assignment({
    this.assignmentCode,
    this.assignmentMark,
    this.type,
    this.assignmentName,
    this.chapterNameAr,
    this.chapterNameEn,
    this.filePath,
    this.lessonNameAr,
    this.lessonNameEn,
    this.publishDate,
    this.publishTime,
    this.totalGrade,
  });
  factory Assignment.fromJson(Map<String, dynamic> json){
    return Assignment(
       assignmentCode: json['assignment_code'],
      assignmentMark: json['student_assignment_mark'],
      assignmentName: json['assignment_name'],
      chapterNameAr: json['chapter_name_ar'],
      chapterNameEn: json['chapter_name_en'],
      filePath: json['file_path'],
      lessonNameAr: json['lesson_name_ar'],
      lessonNameEn: json['lesson_name_en'],
      publishDate: json['publish_date'],
      publishTime: json['publish_time'],
      totalGrade: json['total_grade'],
      type: json['type'],
    );
  }
}
