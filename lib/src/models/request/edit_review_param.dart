import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/professor_review.dart';

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

class EditProfessorReviewParam {
  final Professor? professor;
  final ProfessorReview? review;

  const EditProfessorReviewParam({
    this.review,
    this.professor,
  });
}