import 'package:injectable/injectable.dart';
import 'package:template/global/storage/storage_keys.dart';
import 'package:template/global/storage/storage_provider.dart';
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

  Future<bool> onRefreshToken() async {
    final token = await StorageProvider.instance.get(StorageKeys.token);
    StaticVariable.tokenIsNotChecked = false;
    if (token != null) {
      return true;
    }
    return false;
  }

  Future<bool> onSignOut() async {
    await StorageProvider.instance.delete(StorageKeys.token);
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
}
