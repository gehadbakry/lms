class TeacherQuiz{
  var quizCode , totalGrade , noOfStudents , studentMark , studentRank , rank , grade,classCode,isConfirm,isConfirmStudent;
  String quizName ,date ;

  TeacherQuiz({
    this.date,
    this.rank,
    this.studentMark,
    this.studentRank,
    this.grade,
    this.totalGrade,
    this.quizCode,
    this.quizName,
    this.classCode,
    this.isConfirm,
    this.isConfirmStudent,
    this.noOfStudents,
});

  factory TeacherQuiz.fromJson(Map<String, dynamic> json){
    return TeacherQuiz(
      date: json['date'],
      quizName: json['quiz_name'],
      quizCode: json['quiz_code'],
      totalGrade: json['total_grade_quiz'],
      studentMark: json['student_mark'],
      rank: json['rank'],
      studentRank: json['student_rank'],
      grade: json['grade'],
      classCode: json['class_code'],
      isConfirm: json['is_confirm'],
      isConfirmStudent: json['is_confirm_student'],
      noOfStudents: json['no_of_student'],
    );}
}