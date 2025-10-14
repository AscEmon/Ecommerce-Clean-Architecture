import 'package:equatable/equatable.dart';
import '/features/products/domain/entities/product.dart';

/// Paginated products response
class PaginatedProducts extends Equatable {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  const PaginatedProducts({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  /// Check if there are more products to load
  bool get hasMore => skip + limit < total;

  /// Get next skip value for pagination
  int get nextSkip => skip + limit;

  /// Check if this is the first page
  bool get isFirstPage => skip == 0;

  @override
  List<Object?> get props => [products, total, skip, limit];
}
