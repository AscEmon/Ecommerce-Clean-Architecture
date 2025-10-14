import 'dart:convert';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/preferences_helper.dart';
import '../models/login_response.dart';

/// Local DataSource for Auth feature
/// Handles saving/retrieving auth data from SharedPreferences
abstract class AuthLocalDataSource {
  /// Save complete login response (stores whole object + token separately)
  Future<bool> saveLoginData(LoginResponse loginResponse);

  /// Get complete saved login response
  LoginResponse? getLoginResponse();

  /// Get access token (quick access without parsing full response)
  String? getAccessToken();

  /// Get refresh token
  String? getRefreshToken();

  /// Check if user is logged in (has valid token)
  bool isLoggedIn();

  /// Clear all auth data (logout)
  Future<bool> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final PrefHelper _prefHelper;

  AuthLocalDataSourceImpl({required PrefHelper prefHelper})
    : _prefHelper = prefHelper;

  @override
  Future<bool> saveLoginData(LoginResponse loginResponse) async {
    try {
      // 1. Save complete login response as JSON string
      final jsonString = jsonEncode(loginResponse.toJson());
      await _prefHelper.setString(AppConstants.loginResponse.key, jsonString);

      // 2. Save token separately for quick access (used in API headers)
      if (loginResponse.accessToken != null) {
        await _prefHelper.setString(
          AppConstants.token.key,
          loginResponse.accessToken!,
        );
      }

      // 3. Save refresh token separately
      if (loginResponse.refreshToken != null) {
        await _prefHelper.setString(
          AppConstants.refreshToken.key,
          loginResponse.refreshToken!,
        );
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  LoginResponse? getLoginResponse() {
    try {
      final jsonString = _prefHelper.getString(AppConstants.loginResponse.key);
      if (jsonString.isEmpty) return null;

      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return LoginResponse.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  @override
  String? getAccessToken() {
    final token = _prefHelper.getString(AppConstants.token.key);
    return token.isEmpty ? null : token;
  }

  @override
  String? getRefreshToken() {
    final token = _prefHelper.getString(AppConstants.refreshToken.key);
    return token.isEmpty ? null : token;
  }

  @override
  bool isLoggedIn() {
    final token = getAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<bool> clearAuthData() async {
    try {
      // Clear complete login response
      await _prefHelper.remove(AppConstants.loginResponse.key);
      // Clear tokens
      await _prefHelper.remove(AppConstants.token.key);
      await _prefHelper.remove(AppConstants.refreshToken.key);
      return true;
    } catch (e) {
      return false;
    }
  }
}
