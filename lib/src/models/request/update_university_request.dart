import 'package:template/src/models/response/province.dart';

class UpdateUniversityRaw {
  String? name;
  String? code;
  String? address;
  String? website;
  int? status;

  UpdateUniversityRaw({
    this.name,
    this.code,
    this.address,
    this.website,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schoolName'] = name;
    data['abbrevia'] = code;
    data['address'] = address;
    data['website'] = website;
    data['status'] = status;
    return data;
  }
}
