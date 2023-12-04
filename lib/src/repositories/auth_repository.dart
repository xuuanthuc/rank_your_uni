import 'package:injectable/injectable.dart';
import 'package:template/global/storage/storage_keys.dart';
import 'package:template/global/storage/storage_provider.dart';
import '../../global/utilities/static_variable.dart';
import '../models/request/sign_in_with_email_request.dart';
import './../../src/network/endpoint.dart';
import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class AuthRepository {
  final ApiProvider _apiProvider = getIt.get<ApiProvider>();

  Future<bool> signInWithEmailAndPassword(SignInWithEmailRaw signIn) async {
    try {
      final data = await _apiProvider.post(
        ApiEndpoint.authenticate,
        params: signIn.toJson(),
        needToken: false,
      );
      if (data["data"]["id_token"] != null) {
        await StorageProvider.instance
            .save(StorageKeys.token, data["data"]["id_token"]);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
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
}
