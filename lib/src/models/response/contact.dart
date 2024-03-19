class Contact {
  final int id;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? content;
  final bool? resolve;

  Contact(
    this.id, {
    this.fullName,
    this.phone,
    this.email,
    this.content,
    this.resolve,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final fullName = json["fullName"];
    final phone = json["phone"];
    final email = json["email"];
    final content = json["content"];
    final resolve = json["resolve"];

    return Contact(
      id,
      fullName: fullName,
      phone: phone,
      email: email,
      content: content,
      resolve: resolve,
    );
  }
}
