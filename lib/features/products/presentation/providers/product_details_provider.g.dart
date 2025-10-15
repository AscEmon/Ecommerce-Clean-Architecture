// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for product details that uses AsyncValue for state management

@ProviderFor(ProductDetailsNotifier)
const productDetailsProvider = ProductDetailsNotifierFamily._();

/// Provider for product details that uses AsyncValue for state management
final class ProductDetailsNotifierProvider
    extends
        $AsyncNotifierProvider<ProductDetailsNotifier, ProductDetailsState> {
  /// Provider for product details that uses AsyncValue for state management
  const ProductDetailsNotifierProvider._({
    required ProductDetailsNotifierFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'productDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productDetailsNotifierHash();

  @override
  String toString() {
    return r'productDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductDetailsNotifier create() => ProductDetailsNotifier();

  @override
  bool operator ==(Object other) {
    return other is ProductDetailsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productDetailsNotifierHash() =>
    r'83c1672c39be794e1cc13dd0d3deca9fb4ef7907';

/// Provider for product details that uses AsyncValue for state management

final class ProductDetailsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ProductDetailsNotifier,
          AsyncValue<ProductDetailsState>,
          ProductDetailsState,
          FutureOr<ProductDetailsState>,
          int?
        > {
  const ProductDetailsNotifierFamily._()
    : super(
        retry: null,
        name: r'productDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for product details that uses AsyncValue for state management

  ProductDetailsNotifierProvider call([int? productId]) =>
      ProductDetailsNotifierProvider._(argument: productId, from: this);

  @override
  String toString() => r'productDetailsProvider';
}

/// Provider for product details that uses AsyncValue for state management

abstract class _$ProductDetailsNotifier
    extends $AsyncNotifier<ProductDetailsState> {
  late final _$args = ref.$arg as int?;
  int? get productId => _$args;

  FutureOr<ProductDetailsState> build([int? productId]);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<ProductDetailsState>, ProductDetailsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProductDetailsState>, ProductDetailsState>,
              AsyncValue<ProductDetailsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
