class SignUpWithEmailRaw {
  final String login;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final bool activated;
  final String createdBy;
  final String password;

  SignUpWithEmailRaw({
    required this.login,
    this.imageUrl = '',
    this.activated = false,
    this.createdBy = 'admin',
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login'] = login;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    data['activated'] = activated;
    data['createdBy'] = createdBy;
    data['password'] = password;
    return data;
  }
}
