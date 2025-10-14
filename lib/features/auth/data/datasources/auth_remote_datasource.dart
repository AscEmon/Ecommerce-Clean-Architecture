import '../../../../core/constants/api_urls.dart';
import '../../../../core/network/api_client.dart';
import '../models/login_model.dart';
import '../models/login_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginModel loginModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<LoginResponse> login(LoginModel loginModel) async {
    try {
      final response = await _apiClient.request(
        endpoint: ApiUrl.login.url,
        method: HttpMethod.post,
        data: loginModel.toJson(),
      );
      return LoginResponse.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
