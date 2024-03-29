class Major {
  final int? id;
  final String? name;
  final String? code;

  Major({
    this.id,
    this.name,
    this.code,
  });

  factory Major.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final name = json["name"];
    final code = json["code"];

    return Major(
      id: id,
      name: name,
      code: code,
    );
  }
}
