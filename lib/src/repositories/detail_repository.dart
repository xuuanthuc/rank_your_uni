import 'package:injectable/injectable.dart';
import 'package:template/global/utilities/logger.dart';
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
      needToken: false,
    );
    return University.fromDetailJson(res['data']);
  }

  Future<bool> reviewUniversity(ReviewRaw review) async {
    try {
      final res = await _apiProvider.post(
        ApiEndpoint.reviews,
        needToken: false,
        params: review.toJson(),
      );
      if (res != null) {
        return true;
      }
    } catch (e) {
      LoggerUtils.e(e);
    }
    return false;
  }

  Future<bool> reportReview(ReportRaw report) async {
    try {
      final res = await _apiProvider.post(
        ApiEndpoint.report,
        needToken: false,
        params: report.toJson(),
      );
      if (res != null) {
        return true;
      }
    } catch (e) {
      LoggerUtils.e(e);
    }
    return false;
  }
}
