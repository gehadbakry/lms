class User {
  int Id;
  String UserName;
  User({this.Id,this.UserName});
  factory User.fromJson(Map<String,dynamic>json){
   return User(Id:json['id'],
   UserName: json['username']
   );
  }
}