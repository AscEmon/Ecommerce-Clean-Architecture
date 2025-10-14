import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecommerce/features/products/domain/entities/product.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/get_product_by_id.dart';

part 'product_details_provider.g.dart';

/// Provider for product details that uses AsyncValue for state management
@riverpod
class ProductDetailsNotifier extends _$ProductDetailsNotifier {
  late int _productId;

  @override
  FutureOr<Product> build(int productId) {
    _productId = productId;
    return _fetchProductDetails();
  }

  /// Fetch product details
  Future<Product> _fetchProductDetails() async {
    final getProductByIdUseCase = sl<GetProductById>();
    final result = await getProductByIdUseCase(
      GetProductByIdParams(id: _productId),
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (product) => product,
    );
  }

  /// Refresh the product details
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchProductDetails());
  }
}
