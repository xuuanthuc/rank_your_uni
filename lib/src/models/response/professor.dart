import 'package:template/src/models/response/professor_review.dart';
import 'package:template/src/models/response/university.dart';

class Professor {
  final int id;
  final Major? major;
  final University? university;
  final String? fullName;
  final int? status;
  final double? averagePointAllReviews;
  final List<ProfessorReview>? reviews;
  final int? totalReviews;
  final double? hardAvg;
  final double? pedagogicalAvg;
  final double? professionalAvg;
  final int? reLearnRate;

  const Professor(
    this.id, {
    this.fullName,
    this.major,
    this.university,
    this.status,
    this.reviews,
    this.averagePointAllReviews,
    this.totalReviews,
    this.hardAvg,
    this.pedagogicalAvg,
    this.professionalAvg,
    this.reLearnRate,
  });

  factory Professor.fromJson(Map<String, dynamic> json) {
    final fullName = json['fullName'];
    final id = json['id'];
    final major = Major.fromJson(json['major']);
    final university = University.fromDetailJson(json['school']);
    final status = json['status'] ?? false;
    final reviews = <ProfessorReview>[];
    final averagePointAllReviews =
        double.tryParse(json['averagePointAllReviews'] ?? "") ?? 0.0;

    final hardAvg = double.tryParse(json['hardAvg'] ?? "") ?? 0.0;
    final pedagogicalAvg = double.tryParse(json['pedagogicalAvg'] ?? "") ?? 0.0;
    final professionalAvg =
        double.tryParse(json['professionalAvg'] ?? "") ?? 0.0;
    final reLearnRate = int.tryParse(json['reLearnRate'] ?? "");

    final totalReviews = json['totalReview'];

    if (json['reviewTeachers'] != null) {
      json['reviewTeachers'].forEach((v) {
        reviews.add(ProfessorReview.fromJson(v));
      });
    }

    return Professor(
      id,
      fullName: fullName,
      major: major,
      university: university,
      status: status,
      averagePointAllReviews: averagePointAllReviews,
      reviews: reviews,
      totalReviews: totalReviews,
      hardAvg: hardAvg,
      pedagogicalAvg: pedagogicalAvg,
      professionalAvg: professionalAvg,
      reLearnRate: reLearnRate,
    );
  }
}

class Major {
  final int? id;
  final String? name;
  final String? code;

  const Major({this.name, this.id, this.code});

  factory Major.fromJson(Map<String, dynamic> json) {
    final code = json['code'];
    final id = json['id'];
    final name = json['name'];

    return Major(
      id: id,
      name: name,
      code: code,
    );
  }
}
