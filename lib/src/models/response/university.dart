import 'dart:math';

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
  });

  factory University.fromSearchJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['schoolName'];
    final abbrevia = json['abbrevia'];
    final website = json['website'];
    final address = json['address'];
    final totalReviews =  json['totalReviews'] ?? Random().nextInt(30);
    final averagePointAllReviews =
        double.tryParse(json['averagePointAllReviews']) ?? 0.0;
    final phone = json['phone'];

    return University(
      id,
      name: name,
      abbrevia: abbrevia,
      website: website,
      address: address,
      averagePointAllReviews: averagePointAllReviews,
      phone: phone,
      totalReviews: totalReviews,
    );
  }

  factory University.fromDetailJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['schoolName'];
    final abbrevia = json['abbrevia'];
    final website = json['website'];
    final address = json['address'];
    final totalReviews = json['totalReviews'] ?? Random().nextInt(30);
    final reputationAvg = json['reputationAvg'];
    final internetAvg = json['internetAvg'];
    final locationAvg = json['locationAvg'];
    final facilitiesAvg = json['facilitiesAvg'];
    final foodAvg = json['foodAvg'];
    final clubsAvg = json['clubsAvg'];
    final favoriteAvg = json['favoriteAvg'];
    final competitionLevelAvg = json['competitionLevelAvg'];

    final averagePointAllReviews =
        double.tryParse(json['averagePointAllReviews']) ?? 0.0;
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
    );
  }
}
