class TeacherEvent{
  int divCode;
  var cost,subPermissionDate,schoolYearCode,divSchoolEventDetail,userCode,isPaied,subscriptionDate,isCanceled,cancelDate,isPay;
  String eventDate,eventNameAR,eventNameEN,eventDescriptionAR,eventDescriptionEN,eventLocation,eventTime,eventImage,cancelPermissionDate;

  TeacherEvent({
    this.userCode,this.isPay,
    this.eventLocation,this.eventTime,this.eventDate,this.cost,this.schoolYearCode,this.cancelDate,this.divCode,
    this.divSchoolEventDetail,this.eventDescriptionAR,this.eventDescriptionEN,this.eventImage,this.eventNameAR,
    this.eventNameEN,this.isCanceled,this.isPaied,this.subPermissionDate,this.subscriptionDate,this.cancelPermissionDate
});

  factory TeacherEvent.fromJson(Map<String, dynamic> json){
    return TeacherEvent(
      userCode: json['user_code'],
      eventLocation: json['event_location'],
      eventTime: json['event_time'],
      eventDate: json['event_date'],
      cost: json['cost'],
      schoolYearCode: json['schooling_year_code'],
      cancelDate: json['cancel_date'],
      divCode: json['div_name_code'],
      divSchoolEventDetail: json['div_school_event_details_code'],
      eventDescriptionAR: json['event_description_ar'],
      eventDescriptionEN: json['event_description_en'],
      eventImage: json['event_img'],
      eventNameAR: json['event_name_ar'],
      eventNameEN: json['event_name_en'],
      isCanceled: json['is_cancel'],
      isPaied: json['is_paid'],
      subPermissionDate: json['subscription_permission_date'],
      subscriptionDate: json['subscription_date'],
      cancelPermissionDate: json['cancel_permission_date'],
      isPay: json['is_pay']
    );}
}
class TeacherEventsDateTime{
  int divCode;
  var cost,schoolYearCode,divSchoolEventDetail,userCode,isPaied,isCanceled,isPay;
  String eventNameAR,eventNameEN,eventDescriptionAR,eventDescriptionEN,eventLocation,eventImage, eventTime;
  DateTime eventDate,subPermissionDate,subscriptionDate,cancelDate,cancelPermissionDate;

  TeacherEventsDateTime({
    this.userCode,this.isPay,
    this.eventLocation,this.eventTime,this.eventDate,this.cost,this.schoolYearCode,this.cancelDate,this.divCode,
    this.divSchoolEventDetail,this.eventDescriptionAR,this.eventDescriptionEN,this.eventImage,this.eventNameAR,
    this.eventNameEN,this.isCanceled,this.isPaied,this.subPermissionDate,this.subscriptionDate,this.cancelPermissionDate
  });

}