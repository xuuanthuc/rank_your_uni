import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/university.dart';
import '../models/response/search_response.dart';
import './../../src/network/endpoint.dart';

import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class SearchRepository {
  final ApiProvider _apiProvider = getIt.get<ApiProvider>();

  Future<SearchModel> getUniversities(String keyword, int page) async {
    final res = await _apiProvider.get(
      ApiEndpoint.search,
      params: {
        'keyword': keyword,
        'pageIndex': page,
        'pageSize': 10,
      },
      needToken: false,
    );
    return SearchModel.fromJson(res['data']);
  }

  Future<University> getDetailUniversity(int id) async {
    final res = await _apiProvider.get(
      '${ApiEndpoint.search}/$id',
      needToken: false,
    );
    return University.fromDetailJson(res['data']);
  }
}
