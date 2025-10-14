import 'package:dartz/dartz.dart';
import '/core/error/exceptions.dart';
import '/core/error/failures.dart';
import '/features/cart/data/datasources/cart_local_datasource.dart';
import '/features/cart/domain/entities/cart_item.dart';
import '/features/cart/domain/repositories/cart_repository.dart';
import '/features/products/domain/repositories/product_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;
  final ProductRepository productRepository;

  CartRepositoryImpl({
    required this.localDataSource,
    required this.productRepository,
  });

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      final cartItems = await localDataSource.getCartItems();
      return Right(cartItems);
    } on CacheException {
      return Left(CacheFailure(message: 'Failed to get cart items'));
    }
  }

  @override
  Future<Either<Failure, void>> addToCart(int productId, int quantity) async {
    try {
      // Get product details first
      final productResult = await productRepository.getProductById(productId);
      
      return productResult.fold(
        (failure) => Left(failure),
        (product) async {
          await localDataSource.addToCart(product, quantity);
          return const Right(null);
        },
      );
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuantity(int cartItemId, int quantity) async {
    try {
      await localDataSource.updateQuantity(cartItemId, quantity);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(int cartItemId) async {
    try {
      await localDataSource.removeFromCart(cartItemId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      await localDataSource.clearCart();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
