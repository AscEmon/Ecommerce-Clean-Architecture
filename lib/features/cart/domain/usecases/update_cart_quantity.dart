import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/cart/domain/repositories/cart_repository.dart';

/// Use case for updating cart item quantity
class UpdateCartQuantity implements UseCase<void, UpdateCartQuantityParams> {
  final CartRepository repository;

  UpdateCartQuantity(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateCartQuantityParams params) async {
    return await repository.updateQuantity(params.cartItemId, params.quantity);
  }
}

class UpdateCartQuantityParams extends Equatable {
  final int cartItemId;
  final int quantity;

  const UpdateCartQuantityParams({
    required this.cartItemId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [cartItemId, quantity];
}
