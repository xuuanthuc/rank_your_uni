import 'package:injectable/injectable.dart';
import '../models/response/university.dart';
import './../../src/network/endpoint.dart';

import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class SearchRepository {
  final ApiProvider _apiProvider = getIt.get<ApiProvider>();

  Future<List<University>> getUniversities(String keyword) async {
    List<University> universities = [];
    final res = await _apiProvider.get(
      ApiEndpoint.search,
      params: {'keyword': keyword},
      needToken: false,
    );
    res['data'].forEach((e) => universities.add(University.fromJson(e)));
    return universities;
  }
}
