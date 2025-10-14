import '../../../data/models/login_response.dart';

/// State for login process (form validation handled by Form widget)
class LoginState {
  final LoginResponse? loginResponse;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const LoginState({
    this.loginResponse,
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  const LoginState.initial()
      : loginResponse = null,
        isLoading = false,
        error = null,
        isSuccess = false;

  LoginState copyWith({
    LoginResponse? loginResponse,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return LoginState(
      loginResponse: loginResponse ?? this.loginResponse,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
