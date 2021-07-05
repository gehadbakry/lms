class TeacherJourney{
  int journeyCode,numberOfCompanions;
  bool companionAllowed;
  String journeyName ,dateFrom ,dateTo ,journeyNameAr,journeyNameEn;

  TeacherJourney({
    this.journeyName,
    this.journeyNameAr,
    this.journeyNameEn,
    this.dateTo,
    this.dateFrom,
    this.companionAllowed,
    this.journeyCode,
    this.numberOfCompanions,
});
  factory TeacherJourney.fromJson(Map<String, dynamic> json){
    return TeacherJourney(
      dateTo: json['date_to'],
      dateFrom: json['date_from'],
      companionAllowed: json['companion_allowed'],
      journeyName: json['journey_name'],
      journeyCode: json['journey_code'],
      journeyNameAr: json['journey_name_ar'],
      journeyNameEn: json['journey_name_en'],
      numberOfCompanions: json['max_number_of_companion'],
    );}
}

class TeacherJourneyDateTime{
  int journeyCode,numberOfCompanions;
  bool companionAllowed;
  String journeyName  ,journeyNameAr,journeyNameEn;
  DateTime dateFrom ,dateTo;

  TeacherJourneyDateTime({
    this.journeyName,
    this.journeyNameAr,
    this.journeyNameEn,
    this.dateTo,
    this.dateFrom,
    this.companionAllowed,
    this.journeyCode,
    this.numberOfCompanions,
  });
}

