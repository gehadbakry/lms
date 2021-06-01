class Notifications{
  String date , notificationNmeAr , notificationnameEn ,notificationBodyAr , notificationBodyEn ,seenDate;
  int type ,code;

  Notifications({
    this.type,
    this.code,
    this.date,
    this.notificationBodyAr,
    this.notificationBodyEn,
    this.notificationnameEn,
    this.notificationNmeAr,
    this.seenDate,
});

  factory Notifications.fromJson(Map<String, dynamic> json){
    return Notifications(
      type: json['notification_type_code'],
      date: json['send_date'],
      code: json['code'],
      notificationBodyAr: json['body_ar'],
      notificationBodyEn: json['body_en'],
      notificationnameEn: json['notification_type_name_en'],
        notificationNmeAr: json['notification_type_name_ar'],
      seenDate: json['seen_date'],
    );
  }
}