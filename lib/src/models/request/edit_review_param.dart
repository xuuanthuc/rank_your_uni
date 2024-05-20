import '../response/university_review.dart';
import '../response/university.dart';

class EditReviewParam {
  final University? university;
  final UniversityReview? review;

  const EditReviewParam({
    this.review,
    this.university,
  });
}