class AddProfessorRaw {
  String? fullName;
  int? schoolId;
  int? majorId;

  AddProfessorRaw({
    this.fullName,
    this.schoolId,
    this.majorId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['schoolId'] = schoolId;
    data['majorId'] = majorId;
    return data;
  }
}
