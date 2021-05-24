class Calender {
  String journeyName;
  var cost;
  bool companionAllowed;
  int maxStudent, maxCompanion;
  String dateTo, dateFrom, finalDate, notes;
  String absenceDate, absenceReasonAr, absenceReasonEn, absenceNote;
  var stageVaccDate;
  String vaccNote, vaccNameAr, vaccNameEn;
  String eventNameAr,
      eventNameEn,
      eventDescAr,
      eventDescEn,
      eventTime,
      eventLocation,
      eventDate;
  var eventCost;
  int type;
  String violationNote, violationNameAr, violationNameEn, violationDate;

  Calender({
    this.type,
    this.absenceDate,
    this.absenceNote,
    this.absenceReasonAr,
    this.absenceReasonEn,
    this.cost,
    this.dateFrom,
    this.dateTo,
    this.eventCost,
    this.eventDate,
    this.eventDescAr,
    this.eventDescEn,
    this.eventNameAr,
    this.eventNameEn,
    this.eventTime,
    this.finalDate,
    this.journeyName,
    this.maxCompanion,
    this.maxStudent,
    this.notes,
    this.stageVaccDate,
    this.vaccNameAr,
    this.vaccNameEn,
    this.vaccNote,
    this.violationDate,
    this.violationNameAr,
    this.violationNameEn,
    this.violationNote,
    this.companionAllowed,
    this.eventLocation,
  });

  factory Calender.fromJson(Map<String, dynamic> json) {
    return Calender(
        type: json['type'],
        absenceDate: json['absent_date'],
        absenceNote: json['absent_notes'],
        absenceReasonEn: json['absent_reason_en'],
        absenceReasonAr: json['absent_reason_ar'],
        vaccNameAr: json['vaccination_name_ar'],
        vaccNameEn: json['vaccination_name_en'],
        vaccNote: json['vaccination_notes'],
        stageVaccDate: json['stage_vaccination_date'],
        journeyName: json['journey_name'],
        cost: json['cost'],
        maxStudent: json['max_number_of_student'],
        maxCompanion: json['max_number_of_companion'],
        companionAllowed: json['companion_allowed'],
        dateFrom: json['date_from'],
        dateTo: json['date_to'],
        finalDate: json['final_date'],
        notes: json['notes'],
        eventNameAr:json['event_name_ar'],
        eventNameEn: json['event_name_en'],
        eventDescAr: json['event_description_ar'],
        eventDescEn: json['event_description_en'],
        eventDate: json['event_date'],
        eventTime: json['event_time'],
        eventCost: json['event_cost'],
        violationNote: json['notes_violation'],
        violationDate: json['violation_date'],
        violationNameAr: json['violation_name_ar'],
        violationNameEn: json['violation_name_en'],
        eventLocation: json['event_location']
    );
  }
}