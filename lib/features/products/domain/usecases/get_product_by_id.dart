import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/products/domain/entities/product.dart';
import '/features/products/domain/repositories/product_repository.dart';

/// Use case for getting a product by ID
class GetProductById implements UseCase<Product, GetProductByIdParams> {
  final ProductRepository _repository;

  GetProductById(this._repository);

  @override
  Future<Either<Failure, Product>> call(GetProductByIdParams params) async {
    return await _repository.getProductById(params.id);
  }
}

/// Parameters for GetProductById use case
class GetProductByIdParams extends Equatable {
  final int id;

  const GetProductByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}
