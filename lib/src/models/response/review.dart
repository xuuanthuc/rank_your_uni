class Review {
  final int id;
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
  final int? like;
  final int? dislike;

  Review(
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
    this.like,
    this.dislike,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
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
    final like = json["liked"];
    final dislike = json["disliked"];
    final averagePointPerReview =
        double.tryParse(json["averagePointPerReview"] ?? '') ?? 0.0;

    return Review(
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
      like: like,
      dislike: dislike,
    );
  }
}
