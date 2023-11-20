import 'package:injectable/injectable.dart';
import 'package:template/src/models/request/review_request.dart';
import 'package:template/src/models/response/review.dart';
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
      await _apiProvider.post(
        ApiEndpoint.reviews,
        needToken: false,
        params: review.toJson(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
