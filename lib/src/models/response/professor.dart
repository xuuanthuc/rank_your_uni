import 'package:template/src/models/response/professor_review.dart';

class Professor {
  final int id;
  final int? majorId;
  final int? universityId;
  final String? fullName;
  final bool? status;
  final double? averagePointAllReviews;
  final List<ProfessorReview>? reviews;
  final int? totalReviews;

  const Professor(
    this.id, {
    this.fullName,
    this.majorId,
    this.universityId,
    this.status,
    this.reviews,
    this.averagePointAllReviews,
    this.totalReviews,
  });

  factory Professor.fromJson(Map<String, dynamic> json) {
    final fullName = json['fullName'];
    final id = json['id'];
    final majorId = json['majorId'];
    final universityId = json['universityId'];
    final status = json['status'] ?? false;
    final reviews = <ProfessorReview>[];
    final averagePointAllReviews =
        double.tryParse(json['averagePointAllReviews'] ?? "") ?? 0.0;
    final totalReviews = json['totalReview'];

    if (json['reviewTeachers'] != null) {
      json['reviewTeachers'].forEach((v) {
        reviews.add(ProfessorReview.fromJson(v));
      });
    }

    return Professor(
      id,
      fullName: fullName,
      majorId: majorId,
      universityId: universityId,
      status: status,
      averagePointAllReviews: averagePointAllReviews,
      reviews: reviews,
      totalReviews: totalReviews,
    );
  }
}
