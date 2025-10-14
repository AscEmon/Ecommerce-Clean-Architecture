// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for product items with pagination support

@ProviderFor(ProductNotifier)
const productProvider = ProductNotifierProvider._();

/// Provider for product items with pagination support
final class ProductNotifierProvider
    extends $AsyncNotifierProvider<ProductNotifier, ProductState> {
  /// Provider for product items with pagination support
  const ProductNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productNotifierHash();

  @$internal
  @override
  ProductNotifier create() => ProductNotifier();
}

String _$productNotifierHash() => r'e90627364920f2b29050167b30ce63aa639671e8';

/// Provider for product items with pagination support

abstract class _$ProductNotifier extends $AsyncNotifier<ProductState> {
  FutureOr<ProductState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ProductState>, ProductState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProductState>, ProductState>,
              AsyncValue<ProductState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
