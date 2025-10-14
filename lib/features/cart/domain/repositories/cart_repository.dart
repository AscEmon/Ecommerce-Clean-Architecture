import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item.dart';

/// Abstract repository for cart feature
abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCartItems();
  Future<Either<Failure, void>> addToCart(int productId, int quantity);
  Future<Either<Failure, void>> updateQuantity(int cartItemId, int quantity);
  Future<Either<Failure, void>> removeFromCart(int cartItemId);
  Future<Either<Failure, void>> clearCart();
}
