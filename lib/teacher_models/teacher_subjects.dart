class TeacherSubjects{
  int stageCode,subjectCode ,stageSubjectCode;
  String StageNameAR, StageNameEn ,learningPhaseAR,
  subjectNameAR,subjectNameEn,subjectDescEN,subjectDescAR,image;

  TeacherSubjects({
    this.StageNameEn,
    this.StageNameAR,
    this.subjectNameEn,
    this.subjectNameAR,
    this.subjectDescAR,
    this.subjectDescEN,
    this.learningPhaseAR,
    this.subjectCode,
    this.stageCode,
    this.image,
    this.stageSubjectCode
});

  factory TeacherSubjects.fromJson(Map<String, dynamic> json){
    return TeacherSubjects(
      subjectNameAR: json['subject_name_ar'],
      subjectNameEn: json['subject_name_en'],
      StageNameAR: json['stage_name_ar'],
      StageNameEn: json['stage_name_en'],
      learningPhaseAR: json['learning_phase_name_ar'],
      subjectDescAR: json['subject_desc_ar'],
      subjectDescEN: json['subject_desc_en'],
      subjectCode: json['subject_code'],
      stageCode: json['stage_code'],
      image: json['img_path'],
      stageSubjectCode: json['stage_subject_code']
    );}
}