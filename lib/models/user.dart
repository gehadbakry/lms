class User {
  int Id;
  int UserName;
  String title;
  User({this.Id,this.UserName,this.title});
  factory User.fromJson(Map<String,dynamic>json){
   return User(Id:json['id '],
   UserName: json['userId'],
     title: json['title']
   );
  }
}