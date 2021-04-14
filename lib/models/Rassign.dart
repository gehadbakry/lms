class Assignment {
  String name;
  int id;
  int type;
  String subject;

  Assignment({this.subject,this.id,this.name,this.type});

  factory Assignment.fromJson(Map<String,dynamic>json){
    return Assignment(
      name: json['email'],
      type: json['postId'],
      id: json['id'],
      subject: json['name'],
    );
  }
}