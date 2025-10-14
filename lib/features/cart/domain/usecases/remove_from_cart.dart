import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/cart/domain/repositories/cart_repository.dart';

/// Use case for removing item from cart
class RemoveFromCart implements UseCase<void, int> {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  @override
  Future<Either<Failure, void>> call(int cartItemId) async {
    return await repository.removeFromCart(cartItemId);
  }
}
