class Province {
  final String? name;
  final int? code;
  final List<Districts>? districs;

  const Province({
    this.name,
    this.districs,
    this.code,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final code = json['code'];
    final questions = <Districts>[];

    if (json['districts'] != null) {
      json['districts'].forEach((v) {
        questions.add(Districts.fromJson(v));
      });
    }
    return Province(
      name: name,
      districs: questions,
      code: code,
    );
  }
}

class Districts {
  final String? name;
  final int? code;

  const Districts({
    this.name,
    this.code,
  });

  factory Districts.fromJson(Map<String, dynamic> json) {
    return Districts(
      name: json['name'],
      code: json['code'],
    );
  }
}
