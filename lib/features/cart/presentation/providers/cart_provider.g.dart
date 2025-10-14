// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for cart state management

@ProviderFor(CartNotifier)
const cartProvider = CartNotifierProvider._();

/// Provider for cart state management
final class CartNotifierProvider
    extends $NotifierProvider<CartNotifier, CartState> {
  /// Provider for cart state management
  const CartNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartNotifierHash();

  @$internal
  @override
  CartNotifier create() => CartNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartState>(value),
    );
  }
}

String _$cartNotifierHash() => r'6ae9e322d417e7f71e82e2543c194267283f9720';

/// Provider for cart state management

abstract class _$CartNotifier extends $Notifier<CartState> {
  CartState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CartState, CartState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CartState, CartState>,
              CartState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
