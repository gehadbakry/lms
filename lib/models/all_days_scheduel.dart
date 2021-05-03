class AllDaysScheduel{
  String dayNameAr;
  String dayNameEn;
  int dayCode;

  AllDaysScheduel({
    this.dayCode,
    this.dayNameAr,
    this.dayNameEn,
});

  factory AllDaysScheduel.fromJson(Map<String, dynamic> json){
    return AllDaysScheduel(
      dayCode: json['day_code'],
      dayNameAr: json['day_name_ar'],
      dayNameEn: json['day_name_en'],
    );
  }
}