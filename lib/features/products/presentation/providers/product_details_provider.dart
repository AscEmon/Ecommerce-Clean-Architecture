import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/get_product_by_id.dart';
import 'state/product_details_state.dart';

part 'product_details_provider.g.dart';

/// Provider for product details that uses AsyncValue for state management
@riverpod
class ProductDetailsNotifier extends _$ProductDetailsNotifier {
  late int _productId;

  @override
  FutureOr<ProductDetailsState> build([int? productId]) {
    _productId = productId ?? 0;
    if (productId != null) {
      return _fetchProductDetails();
    }
    return ProductDetailsState();
  }

  /// Fetch product details
  Future<ProductDetailsState> _fetchProductDetails() async {
    final getProductByIdUseCase = sl<GetProductById>();
    final result = await getProductByIdUseCase(
      GetProductByIdParams(id: _productId),
    );

    return result.fold((failure) => throw Exception(failure.message), (
      product,
    ) {
      return ProductDetailsState(product: product);
    });
  }

  Future<void> refresh() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProductDetails());
  }
}
