import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/products/domain/entities/paginated_products.dart';
import '/features/products/domain/repositories/product_repository.dart';

/// Use case for getting paginated products
class GetProducts implements UseCase<PaginatedProducts, GetProductsParams> {
  final ProductRepository _repository;

  GetProducts(this._repository);

  @override
  Future<Either<Failure, PaginatedProducts>> call(
    GetProductsParams params,
  ) async {
    return await _repository.getProducts(params);
  }
}

/// Parameters for GetProducts use case
class GetProductsParams extends Equatable {
  final int limit;
  final int skip;
  final String? searchQuery;
  final String? category;

  const GetProductsParams({
    this.limit = 30, 
    this.skip = 0, 
    this.searchQuery,
    this.category,
  });

  @override
  List<Object?> get props => [limit, skip, searchQuery, category];
}
