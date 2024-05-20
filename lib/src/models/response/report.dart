import 'package:template/src/models/response/university_review.dart';

class Report {
  final int id;
  final String? reportReason;
  final String? reportDate;
  final UniversityReview? review;

  Report(
    this.id, {
    this.reportReason,
    this.reportDate,
    this.review,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final reportReason = json["reportReason"];
    final reportDate = json["reportDate"];
    UniversityReview? review;

    if(json["review"] != null) {
      review = UniversityReview.fromReportJson(json["review"]);
    }

    return Report(
      id,
      reportReason: reportReason,
      reportDate: reportDate,
      review: review,
    );
  }
}
