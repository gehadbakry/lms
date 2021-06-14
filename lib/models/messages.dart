class Messages{
  String messageBody;
  var recieverCode , senderCode;

  Messages({
    this.messageBody,
    this.senderCode,
    this.recieverCode,
});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
   'message':messageBody.trim(),
      'userRecieverCode':recieverCode,
      'userSenderCode':senderCode,
    };

    return map;
  }
}