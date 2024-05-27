import '../response/tag.dart';

class ReviewUniversityRaw {
  final String contentRated;
  final int reputation;
  final int internet;
  final int location;
  final int facilities;
  final int food;
  final int clubs;
  final int favorite;
  final int competitionLevel;
  final int schoolId;
  final String reviewDate;
  final int userId;

  ReviewUniversityRaw({
    required this.contentRated,
    required this.reputation,
    required this.internet,
    required this.location,
    required this.facilities,
    required this.food,
    required this.clubs,
    required this.favorite,
    required this.competitionLevel,
    required this.schoolId,
    required this.reviewDate,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contentRated'] = contentRated;
    data['reputation'] = reputation;
    data['internet'] = internet;
    data['location'] = location;
    data['facilities'] = facilities;
    data['food'] = food;
    data['clubs'] = clubs;
    data['favorite'] = favorite;
    data['competitionLevel'] = competitionLevel;
    data['schoolId'] = schoolId;
    data['reviewDate'] = reviewDate;
    data['likedStatus'] = 0;
    data['userId'] = userId;
    return data;
  }
}

class ReviewProfessorRaw {
  final String courseName;
  final String contentRated;
  final int hard;
  final int pedagogical;
  final int professional;
  final bool? hardAttendance;
  final bool? reLearn;
  final String? point;
  final String reviewDate;
  final int teacherId;
  final int userId;
  final List<Tag> tags;

  ReviewProfessorRaw({
    required this.contentRated,
    required this.hard,
    required this.pedagogical,
    required this.professional,
    required this.courseName,
    required this.teacherId,
    required this.reviewDate,
    required this.userId,
    required this.tags,
    this.hardAttendance,
    this.reLearn,
    this.point,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    final tagIds = [];
    for (var t in tags) {
      tagIds.add(t.id);
    }

    data['contentRated'] = contentRated;
    data['courseName'] = courseName;
    data['hard'] = hard;
    data['hardAttendance'] = hardAttendance;
    data['pedagogical'] = pedagogical;
    data['point'] = point;
    data['professional'] = professional;
    data['teacherId'] = teacherId;
    data['userId'] = userId;
    data['reLearn'] = reLearn;
    data['reviewDate'] = reviewDate;
    data['tagId'] = tagIds;
    data['likedStatus'] = 0;
    data['userId'] = userId;
    return data;
  }
}
