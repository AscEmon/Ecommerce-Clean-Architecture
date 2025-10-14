import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecommerce/core/di/service_locator.dart';

import '../../domain/entities/login_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import 'state/login_state.dart';

part 'login_provider.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() {
    return const LoginState.initial();
  }

  /// Login with email and password (validation handled by Form)
  Future<void> loginWithCredentials(String username, String password) async {
    // Set loading state
    state = state.copyWith(isLoading: true);

    try {
      final loginUseCase = sl<LoginUseCase>();
      final loginEntity = LoginEntity(username: username, password: password);

      final result = await loginUseCase(LoginParams(loginEntity: loginEntity));

      // Check if still mounted
      if (!ref.mounted) return;

      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.message);
        },
        (response) {
          state = state.copyWith(
            isLoading: false,
            loginResponse: response,
            isSuccess: true,
          );
        },
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Reset form and state
  void reset() {
    state = const LoginState.initial();
  }
}
