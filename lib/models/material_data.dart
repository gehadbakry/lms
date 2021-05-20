class Materials {
  int subjectChapterCode;
  String materialName, chapterNameAr, chapterNameEn, lessonNameAr, lessonNameEn;
  String materialPath, publishDate;
  String teacherNameAr, teacherNameEn;
  var chapterNo, subjectChapterLessonCode, subjectChapterLessonMaterialCode,
      lessonNo, materilCode;

  Materials({
    this.teacherNameEn,
    this.teacherNameAr,
    this.lessonNameEn,
    this.lessonNameAr,
    this.publishDate,
    this.materialName,
    this.chapterNameAr,
    this.chapterNameEn,
    this.chapterNo,
    this.lessonNo,
    this.materialPath,
    this.materilCode,
    this.subjectChapterCode,
    this.subjectChapterLessonCode,
    this.subjectChapterLessonMaterialCode
});
  factory Materials.fromJson(Map<String, dynamic> json){
    return Materials(
      teacherNameAr: json['teacherNameAr'],
      teacherNameEn: json['teacherNameEn'],
      materialName: json['material_name'],
      chapterNameAr: json['chapter_name_ar'],
      chapterNameEn: json['chapter_name_en'],
      lessonNameAr: json['lesson_name_ar'],
      lessonNameEn: json['lesson_name_en'],
      publishDate: json['publish_date'],
      chapterNo: json['chapter_no'],
      lessonNo: json['lesson_no'],
      materialPath: json['material_path'],
      materilCode: json['material_type_code'],
      subjectChapterCode: json['subject_chapter_code'],
      subjectChapterLessonCode: json['subject_chapter_lesson_code'],
      subjectChapterLessonMaterialCode: json['subject_chapter_lesson_material_code'],
    );
  }
}