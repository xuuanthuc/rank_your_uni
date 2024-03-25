class UniversityUpdated {
  final String? name;
  final String? address;
  final String? abbrevia;
  final String? website;
  final String? phone;
  final int? status;

  const UniversityUpdated({
    this.name,
    this.address,
    this.abbrevia,
    this.website,
    this.phone,
    this.status,
  });

  factory UniversityUpdated.fromJson(Map<String, dynamic> json) {
    final name = json['schoolName'];
    final abbrevia = json['abbrevia'];
    final website = json['website'];
    final address = json['address'];
    final status = json['status'];
    final phone = json['phone'];
    return UniversityUpdated(
      name: name,
      abbrevia: abbrevia,
      website: website,
      address: address,
      phone: phone,
      status: status,
    );
  }
}