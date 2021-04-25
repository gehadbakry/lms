class BusData {
  int busId;
  String busName;
  String busLabel;
  int zoneCode;
  String zoneNameAr;
  String zoneNameEn;
  String zoneGoTime;
  String zoneBackTime;
  String supervisorName;
  String superNationalId;
  int superPhoneNumb;
  String superAdress;
  String driverName;
  String driverNationalId;
  int driverPhoneNumb;
  String driverAdress;

  BusData({
    this.busId,
    this.busLabel,
    this.busName,
    this.driverAdress,
    this.driverName,
    this.driverNationalId,
    this.driverPhoneNumb,
    this.superAdress,
    this.superNationalId,
    this.superPhoneNumb,
    this.supervisorName,
    this.zoneBackTime,
    this.zoneCode,
    this.zoneGoTime,
    this.zoneNameAr,
    this.zoneNameEn,
  });
  factory BusData.fromJson(Map<String, dynamic> json){
    return BusData(
      busId: json['bus_id'],
      busLabel: json['bus_lable'],
      busName: json['bus_name'],
      driverAdress: json['address_driver'],
      driverName: json['name_driver'],
      driverNationalId: json['national_id_driver'],
      driverPhoneNumb: json['phone_driver'],
      superAdress: json['address_supervisor'],
      superNationalId: json['national_id_supervisor'],
      superPhoneNumb: json['phone_supervisor'],
      supervisorName: json['name_supervisor'],
      zoneBackTime: json['bus_zone_back_time'],
      zoneCode: json['bus_zone_code'],
      zoneGoTime: json['bus_zone_going_time'],
      zoneNameAr: json['bus_zone_name_ar'],
      zoneNameEn: json['bus_zone_name_en'],
    );

  }
}
