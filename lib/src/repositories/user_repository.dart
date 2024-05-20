import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:template/src/models/request/contact.dart';
import 'package:template/src/models/request/password_request.dart';
import 'package:template/src/models/request/profile_request.dart';
import 'package:template/src/models/response/university_review.dart';
import '../models/response/profile.dart';
import '../models/response/response.dart';
import '../network/exception.dart';
import './../../src/network/endpoint.dart';
import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class UserRepository {
  final ApiProvider _apiProvider = getIt.get<ApiProvider>();

  Future<RYUResponse> getUserProfile(String username) async {
    try {
      final data = await _apiProvider.get("${ApiEndpoint.profile}/$username");
      return RYUResponse(isSuccess: true, data: Profile.fromJson(data));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> getMyReviews(String id) async {
    try {
      List<UniversityReview> reviews = [];
      final data = await _apiProvider.get("${ApiEndpoint.myReviews}/$id");
      for (var element in (data['listItem'] as List<dynamic>)) {
        reviews.add(UniversityReview.fromJson(element));
      }
      await compute(sortReviewByDate, reviews);
      return RYUResponse(isSuccess: true, data: reviews);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  List<UniversityReview> sortReviewByDate(List<UniversityReview> reviews) {
    reviews.sort(
      (first, second) => (DateFormat("yyyy-MM-dd'T'hh:mm:SSS'Z'")
              .parse(second.reviewDate ?? '', true)
              .toUtc())
          .compareTo(DateFormat("yyyy-MM-dd'T'hh:mm:SSS'Z'")
              .parse(first.reviewDate ?? '', true)
              .toUtc()),
    );
    return reviews;
  }

  Future<RYUResponse> updateUser(ProfileRaw profileRaw) async {
    try {
      final data = await _apiProvider.put(
        ApiEndpoint.profile,
        params: profileRaw.toJson(),
      );
      return RYUResponse(isSuccess: true, data: Profile.fromJson(data));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> changePassword(PasswordRaw passwordRaw) async {
    try {
      final data = await _apiProvider.post(
        ApiEndpoint.password,
        params: passwordRaw.toJson(),
      );
      return RYUResponse(isSuccess: true, data: data);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> sentContactMessage(ContactRaw contact) async {
    try {
      final data = await _apiProvider.post(
        ApiEndpoint.contact,
        params: contact.toJson(),
        needToken: false,
      );
      return RYUResponse(isSuccess: true, data: data);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }
}
