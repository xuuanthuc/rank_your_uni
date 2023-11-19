import 'package:template/src/models/response/pageable.dart';
import 'package:template/src/models/response/university.dart';

class SearchModel {
  List<University> universities;
  int totalPages;
  Pageable pageable;

  SearchModel({
    required this.universities,
    required this.pageable,
    required this.totalPages,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    final totalPages = json['totalPages'];
    final pageable = Pageable.fromJson(json['pageable']);

    final universities = <University>[];
    if (json['content'] != null) {
      json['content'].forEach((v) {
        universities.add(University.fromSearchJson(v));
      });
    }
    return SearchModel(
      universities: universities,
      totalPages: totalPages,
      pageable: pageable,
    );
  }
}
