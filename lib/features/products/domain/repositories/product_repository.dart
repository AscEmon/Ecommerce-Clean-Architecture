import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/features/products/domain/entities/paginated_products.dart';
import '/features/products/domain/entities/product.dart';
import '/features/products/domain/usecases/get_products.dart';

/// Repository interface for product functionality
abstract class ProductRepository {
  /// Get paginated list of products
  Future<Either<Failure, PaginatedProducts>> getProducts(
    GetProductsParams params,
  );

  /// Get a specific product by ID
  Future<Either<Failure, Product>> getProductById(int id);
}
