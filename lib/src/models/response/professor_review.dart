import 'package:template/src/models/response/tag.dart';
import 'package:template/src/models/response/university_review.dart';

class ProfessorReview {
  final int id;
  final int? teacherId;
  final int? userId;
  final String? courseName;
  final String? teacherName;
  final int? pedagogical;
  final int? professional;
  final int? hard;
  final bool? hardAttendance;
  final bool? reLearn;
  final String? point;
  final String? contentRate;
  final String? reviewDate;
  double? averagePointPerReview;
  final List<Tag>? tags;
  final Liked? liked;
  final int? likedStatus;

  ProfessorReview(
    this.id, {
    this.reviewDate,
    this.averagePointPerReview,
    this.liked,
    this.likedStatus,
    this.userId,
    this.contentRate,
    this.courseName,
    this.hard,
    this.hardAttendance,
    this.pedagogical,
    this.point,
    this.professional,
    this.reLearn,
    this.tags,
    this.teacherId,
    this.teacherName,
  });

  factory ProfessorReview.fromJson(Map<String, dynamic> json) {
    final id = json["id"] ?? -1;
    final userId = json["userId"];
    final courseName = json["courseName"];
    final pedagogical = json["pedagogical"];
    final professional = json["professional"];
    final hard = json["hard"];
    final hardAttendance = json["hardAttendance"];
    final reLearn = json["reLearn"];
    final point = json["point"];
    final contentRate = json["contentRate"];
    final reviewDate = json["reviewDate"];
    final teacherId = json["teacherId"];
    final teacherName = json["teacherName"];
    final averagePointPerReview =
        double.tryParse(json["averagePointPerReview"] ?? '') ?? 0.0;
    final likedStatus = json['likedStatus'];

    final List<Tag> tags = [];
    if (json['tags'] != null) {
      json['tags'].forEach((v) {
        tags.add(Tag.fromJson(v));
      });
    }
    final liked = json['liked'] != null
        ? Liked.fromJson(json['liked'])
        : Liked(
            userDisLiked: [],
            userLiked: [],
          );

    return ProfessorReview(
      id,
      reviewDate: reviewDate,
      averagePointPerReview: averagePointPerReview,
      liked: liked,
      likedStatus: likedStatus,
      userId: userId,
      courseName: courseName,
      pedagogical: pedagogical,
      professional: professional,
      hard: hard,
      hardAttendance: hardAttendance,
      reLearn: reLearn,
      point: point,
      tags: tags,
      contentRate: contentRate,
      teacherId: teacherId,
      teacherName: teacherName,
    );
  }
}
