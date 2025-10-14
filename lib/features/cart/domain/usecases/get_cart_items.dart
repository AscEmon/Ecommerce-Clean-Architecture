import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce/features/cart/domain/repositories/cart_repository.dart';

/// Use case for getting cart items
class GetCartItems implements UseCase<List<CartItem>, NoParams> {
  final CartRepository repository;

  GetCartItems(this.repository);

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams params) async {
    return await repository.getCartItems();
  }
}
