class Professor {
  final int id;
  final int? majorId;
  final int? universityId;
  final String? fullName;

  const Professor(
    this.id, {
    this.fullName,
    this.majorId,
    this.universityId,
  });

  factory Professor.fromJson(Map<String, dynamic> json) {
    final fullName = json['fullName'];
    final id = json['id'];
    final majorId = json['majorId'];
    final universityId = json['universityId'];

    return Professor(
      id,
      fullName: fullName,
      majorId: majorId,
      universityId: universityId,
    );
  }
}
