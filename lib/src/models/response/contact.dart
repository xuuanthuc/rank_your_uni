class Contact {
  final int id;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? content;
  final String? contentReply;
  final bool? resolve;

  Contact(
    this.id, {
    this.fullName,
    this.phone,
    this.email,
    this.content,
    this.resolve,
    this.contentReply,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final fullName = json["fullName"];
    final phone = json["phone"];
    final email = json["email"];
    final content = json["content"];
    final resolve = json["resolve"];
    final contentReply = json["contentReply"];

    return Contact(
      id,
      fullName: fullName,
      phone: phone,
      email: email,
      content: content,
      resolve: resolve,
      contentReply: contentReply,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['email'] = email;
    data['resolve'] = resolve;
    data['content'] = content;
    data['contentReply'] = contentReply;
    return data;
  }
}
