import 'package:dio/dio.dart';
import 'package:ecommerce/core/constants/api_urls.dart';

import '/core/network/api_client.dart';
import '../models/profile_response.dart';

/// Interface for profile remote data source
abstract class ProfileRemoteDataSource {
  /// Get profile from the remote API
  Future<ProfileResponse> getProfile();
}

/// Implementation of profile remote data source
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<ProfileResponse> getProfile() async {
    try {
      final response = await _apiClient.request(
        endpoint: ApiUrl.me.url,
        method: HttpMethod.get,
      );

      return ProfileResponse.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to load profile: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }
}
