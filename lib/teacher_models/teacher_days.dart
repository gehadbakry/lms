class TeacherDays{
  String dayNameAR,dayNameEN;
  var dayCode;
  TeacherDays({
    this.dayNameAR,
    this.dayNameEN,
    this.dayCode
});
  factory TeacherDays.fromJson(Map<String, dynamic> json){
    return TeacherDays(
      dayCode: json['day_code'],
      dayNameAR: json['day_name_ar'],
      dayNameEN: json['day_name_en'],
    );}
}