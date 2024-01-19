class ContactRaw {
  String? fullName;
  String? email;
  String? phone;
  String? message;

  ContactRaw({
    this.fullName,
    this.email,
    this.phone,
    this.message,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['content'] = message;
    return data;
  }
}
