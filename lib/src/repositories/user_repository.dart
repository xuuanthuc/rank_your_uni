import 'package:injectable/injectable.dart';
import 'package:template/src/models/request/password_request.dart';
import 'package:template/src/models/request/profile_request.dart';
import 'package:template/src/models/response/review.dart';
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

  Future<RYUResponse> getMyReviews() async {
    try {
      List<Review> reviews = [];
      final data = await _apiProvider.get(ApiEndpoint.myReviews);
      for (var element in (data['listItem'] as List<dynamic>)) {
        reviews.add(Review.fromJson(element));
      }
      return RYUResponse(isSuccess: true, data: reviews);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
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
}
