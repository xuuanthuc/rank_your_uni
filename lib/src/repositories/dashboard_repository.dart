import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/contact.dart';
import 'package:template/src/models/response/response.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/network/exception.dart';
import '../models/request/sign_in_with_email_request.dart';
import '../models/request/update_university_request.dart';
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

  Future<RYUResponse> getContacts() async {
    try {
      final res = await _apiProvider.get(ApiEndpoint.contacts);
      final List<Contact> contacts = [];
      for (var element in (res['listItem'] as List<dynamic>)) {
        contacts.add(Contact.fromJson(element));
      }
      return RYUResponse(isSuccess: true, data: contacts);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> resolveContacts(Contact contact) async {
    try {
      final res = await _apiProvider.post(
        "${ApiEndpoint.replyContact}/${contact.id}",
        params: {
          "id": contact.id,
          "content": "Okee?",
          "resolve": true,
          "fullName":"Thuc",
          "phone":"0988950581",
          "email":"dothuc273@gmail.com",
        },
      );
      return RYUResponse(isSuccess: true, data: Contact.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> updateUniversity(
      UpdateUniversityRaw newUniversity, University university) async {
    try {
      final res = await _apiProvider.put(
          '${ApiEndpoint.search}/${university.id}',
          params: newUniversity.toJson());
      return RYUResponse(isSuccess: true, data: University.fromSearchJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> deleteUniversity(University university) async {
    try {
      final res =
          await _apiProvider.delete('${ApiEndpoint.search}/${university.id}');
      return RYUResponse(isSuccess: true, data: res);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> signInWithEmailAndPassword(
    SignInWithEmailRaw signIn,
  ) async {
    try {
      final data = await _apiProvider.post(
        ApiEndpoint.authenticate,
        params: signIn.toJson(),
        needToken: false,
      );
      return RYUResponse(isSuccess: true, data: data);
    } on ResponseException catch (e) {
      return RYUResponse(
        errorMessage: e.title,
        code: e.code,
        isSuccess: false,
      );
    }
  }
}
