class Profile {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? university;
  bool? activated;
  String? provider;

  Profile({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.university,
    this.username,
    this.activated,
    this.provider,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final email = json["email"];
    final firstName = json["firstName"];
    final university = json["university"];
    final lastName = json["lastName"];
    final activated = json["activated"];
    final username = json["login"];
    final provider = json["provider"];

    return Profile(
      id: id,
      email: email,
      university: university,
      firstName: firstName,
      lastName: lastName,
      username: username,
      activated: activated,
      provider: provider,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['university'] = university;
    data['lastName'] = lastName;
    data['activated'] = activated;
    data['login'] = username;
    return data;
  }
}
