import 'package:injectable/injectable.dart';
import '../models/response/search_response.dart';
import './../../src/network/endpoint.dart';
import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class SearchRepository {
  final ApiProvider _apiProvider = getIt.get<ApiProvider>();

  Future<SearchModel> getUniversities(String keyword, int page, {int? pageSize}) async {
    final res = await _apiProvider.get(
      ApiEndpoint.search,
      params: {
        'keyword': keyword,
        'pageIndex': page,
        'pageSize': pageSize ?? 10,
      },
    );
    return SearchModel.fromJson(res['data']);
  }
}
