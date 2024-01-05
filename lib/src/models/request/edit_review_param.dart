import '../response/review.dart';
import '../response/university.dart';

class EditReviewParam {
  final University? university;
  final Review? review;

  const EditReviewParam({
    this.review,
    this.university,
  });
}