class AssignmentFile{
  String path;
  AssignmentFile({
    this.path
});
  factory AssignmentFile.fromJson(Map<String, dynamic> json){
    return AssignmentFile(
      path: json['file_path']
    );
  }
}