class ProfileRaw {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String university;
  final String email;

  ProfileRaw({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.university,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['login'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['university'] = university;
    data['authorities'] = ["ROLE_USER"];
    data['activated'] = true;
    return data;
  }
}

