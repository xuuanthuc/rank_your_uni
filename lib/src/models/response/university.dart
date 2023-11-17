import 'package:template/src/models/response/review.dart';

class University {
  final int id;
  final String? name;
  final String? address;
  final String? abbrevia;
  final String? website;
  final String? phone;
  final int? averagePointAllReviews;
  final List<Review>? reviews;

  const University(
    this.id, {
    this.name,
    this.address,
    this.abbrevia,
    this.website,
    this.phone,
    this.averagePointAllReviews,
    this.reviews,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['schoolName'];
    final abbrevia = json['abbrevia'];
    final website = json['website'];
    final address = json['address'];
    final averagePointAllReviews = json['averagePointAllReviews'];
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
    );
  }
}
