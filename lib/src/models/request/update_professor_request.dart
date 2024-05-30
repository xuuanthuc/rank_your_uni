class UpdateProfessorRaw {
  final int id;
  final int? majorId;
  final int? universityId;
  final String? fullName;
  final int? status;

  const UpdateProfessorRaw(
      this.id, {
        this.fullName,
        this.majorId,
        this.universityId,
        this.status,
      });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['majorId'] = majorId;
    data['schoolId'] = universityId;
    data['status'] = status;
    return data;
  }
}
