import 'package:injectable/injectable.dart';
import 'package:template/src/network/exception.dart';
import '../models/response/response.dart';
import '../models/response/search_response.dart';
import './../../src/network/endpoint.dart';
import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class SearchRepository {
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
      return RYUResponse(isSuccess: true, data: SearchModel.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> getProfessores(
      String keyword,
      int page, {
        int? pageSize,
      }) async {
    try {
      final res = await _apiProvider.get(
        ApiEndpoint.professores,
        // params: {
        //   'keyword': keyword,
        //   'pageIndex': page,
        //   'pageSize': pageSize ?? 10,
        // },
      );
      return RYUResponse(isSuccess: true, data: SearchProfessorModel.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }
}
