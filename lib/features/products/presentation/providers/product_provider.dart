import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecommerce/core/utils/extension.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/get_products.dart';
import 'state/product_state.dart';

part 'product_provider.g.dart';

/// Provider for product items with pagination support
@riverpod
class ProductNotifier extends _$ProductNotifier {
  // Private pagination state
  int _currentSkip = 0;

  @override
  FutureOr<ProductState> build() {
    return _fetchFirstPage();
  }

  /// Fetch first page of products
  Future<ProductState> _fetchFirstPage() async {
    final getProductsUseCase = sl<GetProducts>();
    final currentState = state.asData?.value;
    'currentState: ${currentState?.selectedCategory}'.log();

    // Reset pagination state
    _currentSkip = 0;

    final result = await getProductsUseCase(
      GetProductsParams(
        limit: 30,
        skip: 0,
        searchQuery: currentState?.searchQuery,
        category: currentState?.selectedCategory,
      ),
    );

    return result.fold((failure) => throw Exception(failure.message), (
      paginatedProducts,
    ) {
      _currentSkip = paginatedProducts.skip;

      return ProductState(
        products: paginatedProducts.products,
        hasMore: paginatedProducts.hasMore,
        isLoadingMore: false,
        isLoading: false, // Set loading to false when data is fetched
        total: paginatedProducts.total,
        searchQuery: currentState?.searchQuery,
        selectedCategory: currentState?.selectedCategory,
      );
    });
  }

  /// Load more products (pagination)
  Future<void> loadMore() async {
    // Only proceed if state has data
    if (!state.hasValue) return;

    final currentState = state.requireValue;

    // Prevent multiple simultaneous loads
    if (currentState.isLoadingMore || !currentState.hasMore) return;

    // Set loading state
    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    try {
      final getProductsUseCase = sl<GetProducts>();

      // Calculate next skip value
      final nextSkip = _currentSkip + 30;

      final result = await getProductsUseCase(
        GetProductsParams(
          limit: 30,
          skip: nextSkip,
          searchQuery: currentState.searchQuery,
          category: currentState.selectedCategory,
        ),
      );

      result.fold(
        (failure) {
          // Handle error - reset loading state
          state = AsyncData(currentState.copyWith(isLoadingMore: false));
        },
        (paginatedProducts) {
          // Add new products to existing list
          final updatedProducts = [
            ...currentState.products,
            ...paginatedProducts.products,
          ];
          _currentSkip = paginatedProducts.skip;

          // Update state with new products
          state = AsyncData(
            ProductState(
              products: updatedProducts,
              hasMore: paginatedProducts.hasMore,
              isLoadingMore: false,
              total: paginatedProducts.total,
              searchQuery: currentState.searchQuery,
              selectedCategory: currentState.selectedCategory,
            ),
          );
        },
      );
    } catch (e) {
      // Handle error - reset loading state
      state = AsyncData(currentState.copyWith(isLoadingMore: false));
    }
  }

  /// Refresh the entire list (pull to refresh)
  Future<void> refresh() async {
    try {
      // Get current state safely
      final currentState = state.requireValue;

      // Skip if already loading
      if (currentState.isLoading) return;

      // Set loading state but keep other data
      state = AsyncData(currentState.copyWith(isLoading: true));

      // Fetch fresh data
      final result = await _fetchFirstPage();
      state = AsyncData(result);
    } catch (e) {
      // Handle errors
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// Search products by query
  Future<void> searchProducts(String? query) async {
    try {
      // Get current state safely
      final currentState = state.requireValue;

      // Only search if query has changed and not already loading
      if (currentState.searchQuery == query || currentState.isLoading) return;

      // Update state with new search query and set loading flag
      state = AsyncData(
        currentState.copyWith(
          searchQuery: query,
          isLoading: true, // Set loading flag
        ),
      );

      // Fetch results with new query
      final result = await _fetchFirstPage();
      state = AsyncData(result);
    } catch (e) {
      // Handle errors
      state = AsyncError(e, StackTrace.current);
    }
  }

  void setSelectedCategory(String? category) {
    final currentState = state.requireValue;

    // Log the category change for debugging
    'Setting category from ${currentState.selectedCategory} to $category'.log();

    // Update state with new category
    state = AsyncData(currentState.copyWith(selectedCategory: category));

    // Only trigger filtering if the category has actually changed
    if (currentState.selectedCategory != category) {
      _filterByCategory();
    }
  }

  /// Filter products by category
  Future<void> _filterByCategory() async {
    try {
      // Get current state safely
      final currentState = state.requireValue;
      // Only filter if category has changed and not already loading
      if (currentState.isLoading) {
        return;
      }
      state = AsyncData(currentState.copyWith(isLoading: true));

      // Fetch results with new category
      final result = await _fetchFirstPage();
      state = AsyncData(result);
    } catch (e) {
      // Handle errors
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// Clear all filters
  Future<void> clearFilters() async {
    try {
      // Get current state safely
      final currentState = state.requireValue;

      // Only refresh if there were filters applied and not already loading
      if (!currentState.hasFilters || currentState.isLoading) {
        return;
      }

      // First explicitly update the state to clear filters
      // This ensures the UI immediately reflects the cleared filters
      state = AsyncData(
        ProductState(
          products: currentState.products,
          hasMore: currentState.hasMore,
          isLoadingMore: currentState.isLoadingMore,
          total: currentState.total,
          isLoading: true,
          searchQuery: null, // Explicitly set to null
          selectedCategory: null, // Explicitly set to null
        ),
      );

      // Log for debugging
      'Filters cleared, selectedCategory: ${state.requireValue.selectedCategory}'
          .log();

      // Fetch results with cleared filters
      final result = await _fetchFirstPage();
      state = AsyncData(result);
    } catch (e) {
      // Handle errors
      state = AsyncError(e, StackTrace.current);
    }
  }
}
