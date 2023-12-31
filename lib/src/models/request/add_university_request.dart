import 'package:template/src/models/response/province.dart';

class AddUniversityRaw {
  String? name;
  String? code;
  Province? province;
  Districts? districts;
  String? website;
  int? status;

  AddUniversityRaw({
    this.name,
    this.code,
    this.province,
    this.districts,
    this.website,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schoolName'] = name;
    data['abbrevia'] = code;
    data['address'] = '${province?.name}, ${districts?.name}';
    data['website'] = website;
    data['status'] = status;
    return data;
  }
}
