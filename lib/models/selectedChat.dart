class SelectedChat{
  String messageBody;
  String sentDate ,seenDate;
  String senderName;
  int senderCode;
  String imagepath;
  String chatAttatchment;

  SelectedChat({
    this.messageBody,
    this.senderName,
    this.senderCode,
    this.sentDate,
    this.seenDate,
    this.imagepath,
    this.chatAttatchment
});
  factory SelectedChat.fromJson(Map<String, dynamic> json){
    return SelectedChat(
      seenDate: json['seen_date']==null?'':json['seen_date'],
      messageBody: json['MessageBody'],
      senderCode: json['userSenderCode'],
      senderName: json['userSenderName'],
      sentDate: json['send_date'],
      chatAttatchment: json['ChatAttachment'],
      imagepath: json['userSenderImgPath'],
    );
  }
}