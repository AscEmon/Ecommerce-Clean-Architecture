import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/core/network/network_info.dart';
import '/features/products/data/datasources/product_local_datasource.dart';
import '/features/products/data/datasources/product_remote_datasource.dart';
import '/features/products/domain/entities/paginated_products.dart';
import '/features/products/domain/entities/product.dart';
import '/features/products/domain/repositories/product_repository.dart';
import '/features/products/domain/usecases/get_products.dart';

/// Implementation of ProductRepository
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
    required ProductLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, PaginatedProducts>> getProducts(
    GetProductsParams params,
  ) async {
    if (await _networkInfo.internetAvailable()) {
      try {
        final productResponse = await _remoteDataSource.getProducts(params);
        
        // Cache the products
        if (productResponse.products != null) {
          await _localDataSource.cacheProducts(productResponse.products!);
        }
        
        // Convert ProductResponse to PaginatedProducts entity
        final paginatedProducts = PaginatedProducts(
          products: productResponse.products ?? [],
          total: productResponse.total ?? 0,
          skip: productResponse.skip ?? 0,
          limit: productResponse.limit ?? 30,
        );
        
        return Right(paginatedProducts);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localItems = await _localDataSource.getProducts();
        
        // Create paginated response from cached data
        final paginatedProducts = PaginatedProducts(
          products: localItems,
          total: localItems.length,
          skip: 0,
          limit: localItems.length,
        );
        
        return Right(paginatedProducts);
      } catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    if (await _networkInfo.internetAvailable()) {
      try {
        final remoteItem = await _remoteDataSource.getProductById(id);
        await _localDataSource.cacheProduct(remoteItem);
        return Right(remoteItem);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localItem = await _localDataSource.getProductById(id);
        return Right(localItem);
      } catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }
}
