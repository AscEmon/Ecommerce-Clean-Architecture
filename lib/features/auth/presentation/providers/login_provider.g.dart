// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoginNotifier)
const loginProvider = LoginNotifierProvider._();

final class LoginNotifierProvider
    extends $NotifierProvider<LoginNotifier, LoginState> {
  const LoginNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginNotifierHash();

  @$internal
  @override
  LoginNotifier create() => LoginNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginState>(value),
    );
  }
}

String _$loginNotifierHash() => r'f66c963a11d750461df0231e3651d5365c0c1b33';

abstract class _$LoginNotifier extends $Notifier<LoginState> {
  LoginState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LoginState, LoginState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LoginState, LoginState>,
              LoginState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
