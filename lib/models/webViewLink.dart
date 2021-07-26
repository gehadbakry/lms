class WebViewPost{
  var userCode ,examCode;
  WebViewPost({
    this.userCode,
    this.examCode,
});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uc': userCode,
      'examCode': examCode,
    };

    return map;
  }
}
class WebViewResponce{
  String Link;
  WebViewResponce({
  this.Link
      });

}