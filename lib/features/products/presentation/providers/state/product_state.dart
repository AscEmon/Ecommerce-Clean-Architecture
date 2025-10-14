import '../../../domain/entities/product.dart';

/// State class for product list with pagination info
class ProductState {
  final List<Product> products;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isLoading; // Main loading state for filtering and searching
  final int total;
  final String? searchQuery;
  final String? selectedCategory;

  const ProductState({
    required this.products,
    required this.hasMore,
    required this.isLoadingMore,
    this.isLoading = false, // Default to not loading
    required this.total,
    this.searchQuery,
    this.selectedCategory,
  });

  ProductState copyWith({
    List<Product>? products,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isLoading,
    int? total,
    String? searchQuery,
    String? selectedCategory,
  }) {
    return ProductState(
      products: products ?? this.products,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isLoading: isLoading ?? this.isLoading,
      total: total ?? this.total,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
  
  /// Whether any filters are applied
  bool get hasFilters {
    final hasSearchQuery = searchQuery != null && searchQuery!.isNotEmpty;
    final hasCategory = selectedCategory != null && selectedCategory!.isNotEmpty;
    return hasSearchQuery || hasCategory;
  }
}
