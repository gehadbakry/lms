class Rank {
  var noStudent;
  var studentMark;
  var studentRank;
  var rank;

  Rank({this.studentRank, this.studentMark, this.rank, this.noStudent});

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
        studentRank: json['student_rank'],
        studentMark: json['student_mark'],
        rank: json['rank'],
        noStudent: json['no_of_student']);
  }
}
