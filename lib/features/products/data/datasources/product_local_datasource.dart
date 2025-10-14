import '/features/products/data/models/product_model.dart';

/// Interface for product local data source
abstract class ProductLocalDataSource {
  /// Get a list of cached products
  Future<List<ProductModel>> getProducts();

  /// Get a specific cached product by ID
  Future<ProductModel> getProductById(int id);

  /// Cache a list of products
  Future<void> cacheProducts(List<ProductModel> items);

  /// Cache a single product
  Future<void> cacheProduct(ProductModel item);

  /// Clear all cached products
  Future<void> clearCache();
}

/// Implementation of product local data source using in-memory cache
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  // Simple in-memory cache
  final Map<int, ProductModel> _cache = {};

  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (_cache.isEmpty) {
      throw Exception('No cached products available');
    }

    return _cache.values.toList();
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final product = _cache[id];
    if (product == null) {
      throw Exception('Product with id $id not found in cache');
    }

    return product;
  }

  @override
  Future<void> cacheProducts(List<ProductModel> items) async {
    await Future.delayed(const Duration(milliseconds: 100));

    for (final item in items) {
      _cache[item.id] = item;
    }
  }

  @override
  Future<void> cacheProduct(ProductModel item) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    _cache[item.id] = item;
  }

  @override
  Future<void> clearCache() async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    _cache.clear();
  }
}
