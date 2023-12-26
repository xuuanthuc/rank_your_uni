import 'package:injectable/injectable.dart';
import 'package:template/global/storage/storage_keys.dart';
import 'package:template/global/storage/storage_provider.dart';
import 'package:template/src/models/request/profile_request.dart';
import 'package:template/src/models/response/profile.dart';
import '../../global/utilities/static_variable.dart';
import '../models/request/sign_in_with_email_request.dart';
import '../models/request/sign_up_with_email_request.dart';
import '../models/response/response.dart';
import '../network/exception.dart';
import './../../src/network/endpoint.dart';
import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class AuthRepository {
  final ApiProvider _apiProvider = getIt.get<ApiProvider>();

  Future<RYUResponse> signInWithEmailAndPassword(
      SignInWithEmailRaw signIn) async {
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

  Future<RYUResponse> onRefreshToken() async {
    final token = await StorageProvider.instance.get(StorageKeys.token);
    final username = await StorageProvider.instance.get(StorageKeys.username);
    try {
      if (token != null && username != null) {
        StaticVariable.tokenIsNotChecked = false;
        final data = await _apiProvider.get("${ApiEndpoint.profile}/$username");
        return RYUResponse(isSuccess: true, data: Profile.fromJson(data));
      } else {
        return const RYUResponse(isSuccess: false, errorMessage: "", code: 400);
      }
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<bool> onSignOut() async {
    await StorageProvider.instance.delete(StorageKeys.token);
    await StorageProvider.instance.delete(StorageKeys.username);
    StaticVariable.tokenIsNotChecked = true;
    return true;
  }

  Future<RYUResponse> signUpWithEmailAndPassword(
      SignUpWithEmailRaw signUp) async {
    try {
      final data = await _apiProvider.post(
        ApiEndpoint.register,
        params: signUp.toJson(),
        needToken: false,
      );
      return RYUResponse(isSuccess: true, data: data);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> getUserProfile(String username) async {
    try {
      final data = await _apiProvider.get("${ApiEndpoint.profile}/$username");
      return RYUResponse(isSuccess: true, data: Profile.fromJson(data));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }
}
