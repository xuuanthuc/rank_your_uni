class Tag {
  final int? id;
  final String? label;

  Tag({
    this.id,
    this.label,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final label = json["name"];

    return Tag(
      id: id,
      label: label,
    );
  }
}
