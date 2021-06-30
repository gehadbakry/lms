class TeacherMaterial{
  int chapterCode , chapterNo ,chapterLessonCode ,lessonNo , chapterLessonMaterialCode ,materialType,teacherCode;
  String chapterNameAR , chapterNameEN,lessonNameEn,lessonNameAR,materialName,materialpath,publishDate,teacherNameEn,teacherNameAR;

  TeacherMaterial({
    this.teacherCode,
    this.teacherNameEn,
    this.teacherNameAR,
    this.chapterCode,
    this.chapterNo,
    this.chapterLessonCode,
    this.chapterLessonMaterialCode,
    this.chapterNameAR,
    this.chapterNameEN,
    this.lessonNo,
    this.lessonNameEn,
    this.lessonNameAR,
    this.materialName,
    this.materialType,
    this.materialpath,
    this.publishDate
});
  factory TeacherMaterial.fromJson(Map<String, dynamic> json){
    return TeacherMaterial(
      teacherCode: json['teacher_code'],
      teacherNameEn: json['teacherNameEn'],
      teacherNameAR: json['teacherNameAr'],
      lessonNo: json['lesson_no'],
      lessonNameEn: json['lesson_name_en'],
      lessonNameAR: json['lesson_name_ar'],
      chapterLessonCode: json['subject_chapter_lesson_code'],
      chapterLessonMaterialCode: json['subject_chapter_lesson_material_code'],
      chapterNo: json['chapter_no'],
      chapterCode: json['subject_chapter_code'],
      chapterNameAR: json['chapter_name_ar'],
      chapterNameEN: json['chapter_name_en'],
      publishDate: json['publish_date'],
      materialName: json['material_name'],
      materialpath: json['material_path'],
      materialType: json['material_type_code'],
    );}
}