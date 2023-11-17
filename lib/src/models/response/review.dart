class Review {
  final int id;
  final String? content;
  final int? reputation;
  final int? competition;
  final int? favourite;
  final int? internet;
  final int? location;
  final int? facilities;
  final int? food;
  final int? clubs;
  final String? reviewDate;

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
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final content = json["contentRated"];
    final reputation = json["reputation"];
    final competition = json["competitionLevel"];
    final favourite = json["favourite"];
    final internet = json["internet"];
    final location = json["location"];
    final facilities = json["facilities"];
    final food = json["food"];
    final clubs = json["clubs"];
    final reviewDate = json["reviewDate"];

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
    );
  }
}
