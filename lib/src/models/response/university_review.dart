class UniversityReview {
  final int id;
  final int? userId;
  final int? schoolId;
  final String? schoolName;
  final String? content;
  final double? reputation;
  final double? competition;
  final double? favourite;
  final double? internet;
  final double? location;
  final double? facilities;
  final double? food;
  final double? clubs;
  final String? reviewDate;
  double? averagePointPerReview;
  final Liked? liked;
  final int? likedStatus;

  UniversityReview(
    this.id, {
    this.content,
    this.reputation,
    this.competition,
    this.favourite,
    this.internet,
    this.location,
    this.facilities,
    this.food,
    this.clubs,
    this.reviewDate,
    this.averagePointPerReview,
    this.liked,
    this.likedStatus,
    this.userId,
    this.schoolId,
    this.schoolName,
  });

  factory UniversityReview.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final userId = json["userId"];
    final schoolId = json["schoolId"];
    final schoolName = json["schoolName"];
    final content = json["contentRated"];
    final reputation = json["reputation"];
    final competition = json["competitionLevel"];
    final favourite = json["favorite"];
    final internet = json["internet"];
    final location = json["location"];
    final facilities = json["facilities"];
    final food = json["food"];
    final clubs = json["clubs"];
    final reviewDate = json["reviewDate"];
    final averagePointPerReview =
        double.tryParse(json["averagePointPerReview"] ?? '') ?? 0.0;
    final likedStatus = json['likedStatus'];
    final liked = json['liked'] != null
        ? Liked.fromJson(json['liked'])
        : Liked(
            userDisLiked: [],
            userLiked: [],
          );

    return UniversityReview(
      id,
      content: content,
      reputation: reputation,
      competition: competition,
      favourite: favourite,
      internet: internet,
      location: location,
      facilities: facilities,
      food: food,
      clubs: clubs,
      reviewDate: reviewDate,
      averagePointPerReview: averagePointPerReview,
      liked: liked,
      likedStatus: likedStatus,
      userId: userId,
      schoolId: schoolId,
      schoolName: schoolName,
    );
  }

  factory UniversityReview.fromReportJson(Map<String, dynamic> json) {
    final id = json["id"];
    final userId = json["user"]["id"];
    final schoolId = json["school"]["id"];
    final schoolName = json["school"]["schoolName"];
    final content = json["contentRated"];
    final reputation = json["reputation"];
    final competition = json["competitionLevel"];
    final favourite = json["favorite"];
    final internet = json["internet"];
    final location = json["location"];
    final facilities = json["facilities"];
    final food = json["food"];
    final clubs = json["clubs"];
    final reviewDate = json["reviewDate"];

    return UniversityReview(
      id,
      content: content,
      reputation: reputation,
      competition: competition,
      favourite: favourite,
      internet: internet,
      location: location,
      facilities: facilities,
      food: food,
      clubs: clubs,
      reviewDate: reviewDate,
      userId: userId,
      schoolId: schoolId,
      schoolName: schoolName,
    );
  }
}

class Liked {
  List<int>? userLiked;
  List<int>? userDisLiked;

  Liked({this.userLiked, this.userDisLiked});

  Liked.fromJson(Map<String, dynamic> json) {
    userLiked = json['userLiked'].cast<int>();
    userDisLiked = json['userDisLiked'].cast<int>();
  }
}
