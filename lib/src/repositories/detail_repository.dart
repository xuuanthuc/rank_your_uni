import 'package:injectable/injectable.dart';
import 'package:template/src/models/request/report_request.dart';
import 'package:template/src/models/request/review_request.dart';
import 'package:template/src/models/response/university.dart';
import './../../src/network/endpoint.dart';
import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class DetailRepository {
  final ApiProvider _apiProvider = getIt.get<ApiProvider>();

  Future<University> getDetailUniversity(int id) async {
    final res = await _apiProvider.get(
      '${ApiEndpoint.search}/$id',
    );
    return University.fromDetailJson(res['data']);
  }

  Future<bool> reviewUniversity(ReviewRaw review) async {
    try {
      final res = await _apiProvider.post(
        ApiEndpoint.reviews,
        params: review.toJson(),
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

  Future<bool> likeReview(int id) async {
    try {
      final res = await _apiProvider.put(
        "${ApiEndpoint.reviews}/$id",
        params: {"liked": 1},
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

  Future<bool> dislikeReview(int id) async {
    try {
      final res = await _apiProvider.put(
        "${ApiEndpoint.reviews}/$id",
        params: {"disliked": 1},
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
}
