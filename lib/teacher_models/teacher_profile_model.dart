class TeacherModel{
  String NameAR , NameEN, StageNameAr , StageNameEn,classNameAR ,
      classNameEn,phaseNameAR,phaseNameEn,aboutMeEn,aboutMeAr ,image,
  email,SpecialistAR,specialistEN;

  TeacherModel({
    this.NameAR,
    this.NameEN,
    this.classNameAR,
    this.classNameEn,
    this.StageNameAr,
    this.StageNameEn,
    this.phaseNameAR,
    this.phaseNameEn,
    this.aboutMeEn,
    this.aboutMeAr,
    this.image,
    this.email,
    this.SpecialistAR,
    this.specialistEN
});
  factory TeacherModel.fromJson(Map<String, dynamic> json){
    return TeacherModel(
      NameAR: json['teacher_full_name_ar'],
      NameEN: json['teacher_full_name_en'],
      classNameAR: json['school_class_name_ar'],
      classNameEn: json['school_class_name_en'],
      phaseNameAR: json['learning_phase_name'],
      phaseNameEn: json['learning_phase_name_en'],
      StageNameAr: json['stage_name_ar'],
      StageNameEn: json['stage_name_en'],
      image: json['img_path'],
      aboutMeAr: json['about_me_ar'],
      aboutMeEn: json['about_me'],
      email: json['email'],
      SpecialistAR: json['Specialist_name_ar'],
      specialistEN: json['Specialist_name_en']
    );}
}