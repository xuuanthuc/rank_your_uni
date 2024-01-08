import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/response.dart';
import 'package:template/src/network/exception.dart';
import '../models/response/search_response.dart';
import './../../src/network/endpoint.dart';
import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class DashboardRepository {
  final ApiProvider _apiProvider = getIt.get<ApiProvider>();

  Future<RYUResponse> getUniversities(
      String keyword,
      int page, {
        int? pageSize,
      }) async {
    try {
      final res = await _apiProvider.get(
        ApiEndpoint.search,
        params: {
          'keyword': keyword,
          'pageIndex': page,
          'pageSize': pageSize ?? 10,
        },
      );
      return RYUResponse(isSuccess: true, data: SearchModel.fromAdminJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }
}
