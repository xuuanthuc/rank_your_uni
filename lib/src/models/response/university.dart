import 'package:template/src/models/response/review.dart';

class University {
  final int id;
  final String? name;
  final String? address;
  final String? abbrevia;
  final String? website;
  final String? phone;
  final double? averagePointAllReviews;
  final List<Review>? reviews;
  final double? reputationAvg;
  final double? internetAvg;
  final double? locationAvg;
  final double? facilitiesAvg;
  final double? foodAvg;
  final double? clubsAvg;
  final double? favoriteAvg;
  final double? competitionLevelAvg;
  final int? totalReviews;
  final int? status;

  const University(
    this.id, {
    this.name,
    this.address,
    this.abbrevia,
    this.website,
    this.phone,
    this.averagePointAllReviews,
    this.reviews,
    this.reputationAvg,
    this.internetAvg,
    this.locationAvg,
    this.facilitiesAvg,
    this.foodAvg,
    this.clubsAvg,
    this.favoriteAvg,
    this.competitionLevelAvg,
    this.totalReviews,
    this.status,
  });

  factory University.fromSearchJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['schoolName'];
    final abbrevia = json['abbrevia'];
    final website = json['website'];
    final address = json['address'];
    final totalReviews = json['totalReview'];
    final status = json['status'];
    final averagePointAllReviews =
        double.tryParse(json['averagePointAllReviews'] ?? "") ?? 0.0;
    final phone = json['phone'];
    final reputationAvg = double.tryParse(json['reputationAvg'] ?? "") ?? 0.0;
    final internetAvg = double.tryParse(json['internetAvg'] ?? "") ?? 0.0;
    final locationAvg = double.tryParse(json['locationAvg'] ?? "") ?? 0.0;
    final facilitiesAvg = double.tryParse(json['facilitiesAvg'] ?? "") ?? 0.0;
    final foodAvg = double.tryParse(json['foodAvg'] ?? "") ?? 0.0;
    final clubsAvg = double.tryParse(json['clubsAvg'] ?? "") ?? 0.0;
    final favoriteAvg = double.tryParse(json['favoriteAvg'] ?? "") ?? 0.0;
    final competitionLevelAvg =
        double.tryParse(json['competitionLevelAvg'] ?? "") ?? 0.0;
    return University(
      id,
      name: name,
      abbrevia: abbrevia,
      website: website,
      address: address,
      averagePointAllReviews: averagePointAllReviews,
      phone: phone,
      totalReviews: totalReviews,
      reputationAvg: reputationAvg,
      internetAvg: internetAvg,
      locationAvg: locationAvg,
      facilitiesAvg: facilitiesAvg,
      foodAvg: foodAvg,
      clubsAvg: clubsAvg,
      favoriteAvg: favoriteAvg,
      competitionLevelAvg: competitionLevelAvg,
      status: status,
    );
  }

  factory University.fromDetailJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['schoolName'];
    final abbrevia = json['abbrevia'];
    final website = json['website'];
    final address = json['address'];
    final status = json['status'];
    final totalReviews = json['totalReview'];
    final reputationAvg = double.tryParse(json['reputationAvg'] ?? "") ?? 0.0;
    final internetAvg = double.tryParse(json['internetAvg'] ?? "") ?? 0.0;
    final locationAvg = double.tryParse(json['locationAvg'] ?? "") ?? 0.0;
    final facilitiesAvg = double.tryParse(json['facilitiesAvg'] ?? "") ?? 0.0;
    final foodAvg = double.tryParse(json['foodAvg'] ?? "") ?? 0.0;
    final clubsAvg = double.tryParse(json['clubsAvg'] ?? "") ?? 0.0;
    final favoriteAvg = double.tryParse(json['favoriteAvg'] ?? "") ?? 0.0;
    final competitionLevelAvg =
        double.tryParse(json['competitionLevelAvg'] ?? "") ?? 0.0;
    final averagePointAllReviews =
        double.tryParse(json['averagePointAllReviews'] ?? "") ?? 0.0;
    final phone = json['phone'];
    final reviews = <Review>[];
    if (json['reviews'] != null) {
      json['reviews'].forEach((v) {
        reviews.add(Review.fromJson(v));
      });
    }
    return University(
      id,
      name: name,
      abbrevia: abbrevia,
      website: website,
      address: address,
      averagePointAllReviews: averagePointAllReviews,
      phone: phone,
      reviews: reviews,
      reputationAvg: reputationAvg,
      internetAvg: internetAvg,
      locationAvg: locationAvg,
      facilitiesAvg: facilitiesAvg,
      foodAvg: foodAvg,
      clubsAvg: clubsAvg,
      favoriteAvg: favoriteAvg,
      competitionLevelAvg: competitionLevelAvg,
      totalReviews: totalReviews,
      status: status,
    );
  }

  University copyWith({List<Review>? newReviews}) {
    return University(
      id,
      name: name,
      abbrevia: abbrevia,
      website: website,
      address: address,
      averagePointAllReviews: averagePointAllReviews,
      phone: phone,
      reviews: newReviews,
      reputationAvg: reputationAvg,
      internetAvg: internetAvg,
      locationAvg: locationAvg,
      facilitiesAvg: facilitiesAvg,
      foodAvg: foodAvg,
      clubsAvg: clubsAvg,
      favoriteAvg: favoriteAvg,
      competitionLevelAvg: competitionLevelAvg,
      totalReviews: totalReviews,
      status: status,
    );
  }
}
