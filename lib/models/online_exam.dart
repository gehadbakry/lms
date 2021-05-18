class OnlineExams{
  int examCode;
  String examName;
  var totalGrade;
  String publishDate;
  String publishTime;
  var studentMark;
  String chapterNameAr;
  String chapterNameEn;
  String lessonNameAr;
  String lessonNameEn;

  OnlineExams({
    this.studentMark,
    this.lessonNameEn,
    this.publishDate,
    this.totalGrade,
    this.publishTime,
    this.lessonNameAr,
    this.chapterNameEn,
    this.chapterNameAr,
    this.examCode,
    this.examName
});

  factory OnlineExams.fromJson(Map<String, dynamic> json){
    return OnlineExams(
      studentMark: json['student_exam_mark'],
      totalGrade: json['total_grade'],
      publishTime: json['publish_time'],
      publishDate: json['publish_date'],
      lessonNameEn: json['lesson_name_en'],
      lessonNameAr: json['lesson_name_ar'],
      chapterNameEn: json['chapter_name_en'],
      chapterNameAr: json['chapter_name_ar'],
      examCode: json['exam_code'],
      examName: json['exam_name'],
    );
  }

}