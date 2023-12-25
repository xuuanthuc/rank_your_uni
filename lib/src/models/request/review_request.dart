class ReviewRaw {
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

  ReviewRaw({
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
