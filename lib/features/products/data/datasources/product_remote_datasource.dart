import 'package:dio/dio.dart';

import '../../../../core/constants/api_urls.dart';
import '/core/network/api_client.dart';
import '/features/products/data/models/product_model.dart';
import '/features/products/data/models/product_response.dart';
import '/features/products/domain/usecases/get_products.dart';

/// Interface for product remote data source
abstract class ProductRemoteDataSource {
  /// Get paginated products from the remote API
  Future<ProductResponse> getProducts(GetProductsParams params);

  /// Get a specific product by ID from the remote API
  Future<ProductModel> getProductById(int id);
}

/// Implementation of product remote data source
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient _apiClient;

  ProductRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<ProductResponse> getProducts(GetProductsParams params) async {
    try {
      String endpoint = '${ApiUrl.products.url}?limit=${params.limit}&skip=${params.skip}';
      
      // Add search query parameter if provided
      if (params.searchQuery != null && params.searchQuery!.isNotEmpty) {
        endpoint += '&q=${params.searchQuery}';
      }
      
      // Add category filter if provided
      if (params.category != null && params.category!.isNotEmpty) {
        endpoint = '${ApiUrl.products.url}/category/${params.category}?limit=${params.limit}&skip=${params.skip}';
        
        // Add search query to category endpoint if provided
        if (params.searchQuery != null && params.searchQuery!.isNotEmpty) {
          endpoint += '&q=${params.searchQuery}';
        }
      }

      final response = await _apiClient.request(
        endpoint: endpoint,
        method: HttpMethod.get,
      );

      return ProductResponse.fromJson(response as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to load products: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _apiClient.request(
        endpoint: '${ApiUrl.products.url}/$id',
        method: HttpMethod.get,
      );
      return ProductModel.fromJson(response as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to load product: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }
}
