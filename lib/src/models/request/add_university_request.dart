import 'package:template/src/models/response/province.dart';

class AddUniversityRaw {
  String? name;
  Province? province;
  Districts? districts;
  String? website;
  String? creatorEmail;

  AddUniversityRaw({
    this.name,
    this.province,
    this.districts,
    this.website,
    this.creatorEmail,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contentRated'] = name;
    data['reputation'] = '${province?.name}, ${districts?.name}';
    data['internet'] = website;
    data['reviewDate'] = creatorEmail;
    return data;
  }
}
