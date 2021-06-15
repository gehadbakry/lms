class AllCount{
  var allNotification;
  AllCount({
    this.allNotification
  });
  factory AllCount.fromJson(Map<String, dynamic> json){
    return AllCount(
      allNotification: json['notificationCount'],
    );
  }
}

class TypeNotification{
  var typeCode,count;
  TypeNotification({
    this.count,
    this.typeCode
});
  factory TypeNotification.fromJson(Map<String, dynamic> json){
    return TypeNotification(
        typeCode: json['notification_type_code'],
      count: json['notification_count'],
    );
  }
}

class updateNotification{
  var userCode,Notificationtype;
  updateNotification({
    this.userCode,
    this.Notificationtype,
});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'userCode':userCode,
      'notification_type_code':Notificationtype,
    };

    return map;
  }

}

class countByType{
  var singleTypeCount;
  countByType({
    this.singleTypeCount
});
  factory countByType.fromJson(Map<String, dynamic> json){
    return countByType(
      singleTypeCount: json['notificationCount'],
    );}
}