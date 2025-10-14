import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/cart/domain/repositories/cart_repository.dart';

/// Use case for adding item to cart
class AddToCart implements UseCase<void, AddToCartParams> {
  final CartRepository repository;

  AddToCart(this.repository);

  @override
  Future<Either<Failure, void>> call(AddToCartParams params) async {
    return await repository.addToCart(params.productId, params.quantity);
  }
}

class AddToCartParams extends Equatable {
  final int productId;
  final int quantity;

  const AddToCartParams({
    required this.productId,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [productId, quantity];
}
