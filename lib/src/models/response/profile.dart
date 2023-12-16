class Profile {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  bool? activated;

  Profile({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.activated,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final email = json["email"];
    final firstName = json["firstName"];
    final lastName = json["lastName"];
    final activated = json["activated"];
    final username = json["login"];

    return Profile(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      username: username,
      activated: activated,
    );
  }
}
