import 'package:template/src/models/response/pageable.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/university.dart';

class SearchModel {
  List<University> universities;
  int totalPages;
  int totalElements;
  Pageable pageable;

  SearchModel({
    required this.universities,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    final totalPages = json['totalPages'];
    final totalElements = json['totalElements'];
    final pageable = Pageable.fromJson(json['pageable']);

    final universities = <University>[];
    if (json['content'] != null) {
      json['content'].forEach((v) {
        final university = University.fromSearchJson(v);
        if (university.status == 1) {
          universities.add(university);
        }
      });
    }
    return SearchModel(
      universities: universities,
      totalPages: totalPages,
      pageable: pageable,
      totalElements: totalElements,
    );
  }

  factory SearchModel.fromAdminJson(Map<String, dynamic> json) {
    final totalPages = json['totalPages'];
    final totalElements = json['totalElements'];
    final pageable = Pageable.fromJson(json['pageable']);

    final universities = <University>[];
    if (json['content'] != null) {
      json['content'].forEach((v) {
        final university = University.fromSearchJson(v);
        universities.add(university);
      });
    }
    return SearchModel(
      universities: universities,
      totalPages: totalPages,
      pageable: pageable,
      totalElements: totalElements,
    );
  }
}


class SearchProfessorModel {
  List<Professor> professores;
  int totalPages;
  int totalElements;
  Pageable pageable;

  SearchProfessorModel({
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.professores,
  });

  factory SearchProfessorModel.fromJson(Map<String, dynamic> json) {
    // final totalPages = json['totalPages'];
    // final totalElements = json['totalElements'];
    // final pageable = Pageable.fromJson(json['pageable']);
    final professores = <Professor>[];
    if (json['content'] != null) {
      json['content'].forEach((v) {
        final professor = Professor.fromJson(v);
        professores.add(professor);

      });
    }
    return SearchProfessorModel(
      professores: professores,
      totalPages: 0,
      pageable: Pageable(pageNumber: 0, pageSize: 0),
      totalElements: 10,
    );
  }
}
