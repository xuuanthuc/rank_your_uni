import 'package:injectable/injectable.dart';
import 'package:template/src/models/request/report_request.dart';
import 'package:template/src/models/request/review_request.dart';
import 'package:template/src/models/response/response.dart';
import 'package:template/src/models/response/review.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/network/exception.dart';
import './../../src/network/endpoint.dart';
import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class DetailRepository {
  final ApiProvider _apiProvider = getIt.get<ApiProvider>();

  Future<RYUResponse> getDetailUniversity(int id) async {
    try {
      final res = await _apiProvider.get(
        '${ApiEndpoint.search}/$id',
      );
      return RYUResponse(isSuccess: true, data: University.fromDetailJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> reviewUniversity(ReviewRaw review) async {
    try {
      final res = await _apiProvider.post(
        ApiEndpoint.reviews,
        params: review.toJson(),
      );
      return RYUResponse(isSuccess: true, data: Review.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<bool> reportReview(ReportRaw report) async {
    try {
      final res = await _apiProvider.post(
        ApiEndpoint.report,
        params: report.toJson(),
      );
      if (res != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RYUResponse> likeReview(int id) async {
    try {
      final res = await _apiProvider.put(
        "${ApiEndpoint.reviews}/$id",
        params: {
          "liked": 1,
          "id": id,
        },
      );
      return RYUResponse(isSuccess: true, data: Review.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> dislikeReview(int id) async {
    try {
      final res = await _apiProvider.put(
        "${ApiEndpoint.reviews}/$id",
        params: {
          "disliked": 1,
          "id": id,
        },
      );
      return RYUResponse(isSuccess: true, data: Review.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }
}
