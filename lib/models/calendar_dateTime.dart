 class CalenderDateTime {
  String journeyName, notes;
  var cost;
  bool companionAllowed;
  int maxStudent, maxCompanion;
  DateTime dateTo, dateFrom, finalDate,absenceDate,stageVaccDate, eventDate, violationDate;
  String absenceReasonAr, absenceReasonEn, absenceNote;
  String vaccNote, vaccNameAr, vaccNameEn;
  String eventNameAr, eventNameEn, eventDescAr, eventDescEn, eventTime ,eventLocation;
  var eventCost;
  int type;
  String violationNote, violationNameAr, violationNameEn;

  CalenderDateTime({
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
    this.eventLocation
  });
  }
