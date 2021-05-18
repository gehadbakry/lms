class Recents{
int assignmentCode , examCode ;
String subjectNameAr , subjectNameEn;
//int   materialCode ,quizCode ;
String assignmentName , examName ;
//String materialName , quizName;
var assignmentMark , studentExamMark ;
//var studentQuizMark ;
String assignChapterNameAr ,examChapterNameAr;
//String materialChapterNameAr ;
String assignChapterNameEn,examChapterNameEn ;
//String materialChapterNameEn;
String assignLessonNameAr ,examLessonNameAr;
String materialLessonNameAr ;
String assignLessonNameEn , examLessonNameEn ;
String materialLessonNameEn;
String filePath;
String assignsubjectNameEn;
  String assignsubjectNameAr;
 //String   materialpath;
var type;
//var materialType;
var totalAssignmentGrade , totalExamMark ;
var totalQuizMark;
int typeRecent;

Recents({
  this.assignmentCode , this.assignmentName , this.assignmentMark , this.filePath,
  this.assignChapterNameAr ,this.assignChapterNameEn,this.assignLessonNameAr ,this.assignLessonNameEn,
  this.totalAssignmentGrade,
  this.examCode,this.examName,this.studentExamMark,
  this.examChapterNameAr,this.examChapterNameEn,this.examLessonNameAr,this.examLessonNameEn,
  this.totalExamMark,
  // this.quizName,this.quizCode,this.studentQuizMark,this.totalQuizMark,
  // this.materialName,this.materialCode,
  // this.materialChapterNameAr,this.materialChapterNameEn,this.materialLessonNameAr,this.materialLessonNameEn,
  // this.materialpath , this.materialType,
  this.type,this.typeRecent,
  this.subjectNameEn, this.subjectNameAr,
  this.assignsubjectNameEn, this.assignsubjectNameAr,
});

factory Recents.fromJson(Map<String, dynamic> json){
  return Recents(
    examCode: json['exam_code'],
    examName: json['exam_name'],
    examChapterNameAr: json['chapter_name_ar'],
    examChapterNameEn: json['chapter_name_en'],
    examLessonNameAr: json['lesson_name_ar'],
    examLessonNameEn: json['lesson_name_en'],
    studentExamMark: json['student_exam_mark'],
    totalExamMark: json['total_grade'],
    assignmentCode: json['assignment_code'],
    assignmentName: json['assignment_name'],
    assignmentMark: json['student_assignment_mark'],
    assignChapterNameAr: json['chapter_name_ar_ass'],
    assignChapterNameEn: json['chapter_name_en_ass'],
    assignLessonNameAr: json['lesson_name_ar_ass'],
    assignLessonNameEn: json['lesson_name_en_ass'],
    totalAssignmentGrade: json['total_grade_ass'],
    filePath: json['file_path'],
    type: json['type'],
    subjectNameAr: json['subject_name_ar'],
    subjectNameEn: json['subject_name_en'],
    assignsubjectNameAr: json['subject_name_ar_ass'],
    assignsubjectNameEn: json['subject_name_en_ass'],
    // materialCode: json['material_code'],
    // materialName: json['material_name'],
    // materialpath: json['material_path'],
    // materialType: json['material_type'],
    // materialChapterNameAr: json['chapter_name_ar_material'],
    // materialChapterNameEn: json['chapter_name_en_material'],
    // materialLessonNameAr: json['lesson_name_ar_material'],
    // materialLessonNameEn: json['lesson_name_en_material'],
    // quizCode: json['quiz_code'],
    // quizName: json['quiz_name'],
    // studentQuizMark: ['student_quiz_mark'],
    // totalQuizMark: json['total_grade_quiz'],
    typeRecent: json['type_recent'],
  );
}
}