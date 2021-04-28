class Quiz{
  int quizCode;
  String quizName;
  double grade;
  double totalQuizGrade;
  int noStudents;
  double studentMark;
  int studentRank;
  int rank;
  String date;

  Quiz({
  this.date,
  this.grade,
  this.noStudents,
  this.quizCode,
  this.quizName,
  this.rank,
  this.studentMark,
  this.studentRank,
  this.totalQuizGrade,
});

  factory Quiz.fromJson(Map<String, dynamic> json){
   return Quiz(
     date: json['date'],
     grade: json['grade'],
     noStudents: json['no_of_student'],
     quizCode: json['quiz_code'],
     quizName: json['quiz_name'],
     rank: json['rank'],
     studentMark: json['student_mark'],
     studentRank: json['student_rank'],
     totalQuizGrade: json['total_grade_quiz'],
   );
  }
  }