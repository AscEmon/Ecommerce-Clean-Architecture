import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/core/presentation/widgets/global_loader.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';
import 'package:ecommerce/core/routes/navigation.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/features/products/presentation/providers/state/product_state.dart';

import '../../../../core/routes/app_routes.dart';
import '../providers/product_provider.dart';
import '../widgets/category_filter.dart';
import '../widgets/product_card.dart';
import '../widgets/product_search_bar.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key});

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Listen to scroll events for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Handle scroll events for infinite scroll
  void _onScroll() {
    // Check if user scrolled to bottom (with 200px threshold)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more products
      ref.read(productProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);
    final notifier = ref.read(productProvider.notifier);

    return Scaffold(
      body: state.when(
        loading: () => const Center(child: GlobalLoader(text: '')),
        error: (error, stackTrace) {
          return const Center(
            child: GlobalText(str: 'Something went wrong. Please try again.'),
          );
        },
        data: (productListState) {
          final products = productListState.products;

          return Column(
            children: [
              // Search bar
              const ProductSearchBar(),

              // Category filter
              const CategoryFilter(),

              // Results count and loading indicator
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                  vertical: 8.0.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Show loading indicator or product count
                    GlobalText(
                      str: '${productListState.products.length} Products',
                      fontWeight: FontWeight.w600,
                    ),
                    if (productListState.hasFilters)
                      TextButton(
                        onPressed: () {
                          notifier.clearFilters();
                        },
                        child: GlobalText(
                          str: 'Clear Filters',
                          color: AppColors.primary.color,
                        ),
                      ),
                  ],
                ),
              ),

              // Product list
              Expanded(
                child:
                    products.isEmpty
                        // Show empty state when no products found
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64.r,
                                color: AppColors.grey.color,
                              ),
                              SizedBox(height: 16.h),
                              const GlobalText(str: 'No products found'),
                              SizedBox(height: 8.h),
                              GlobalText(
                                str: 'Try different search terms or categories',
                              ),
                            ],
                          ),
                        )
                        // Show product list
                        : RefreshIndicator(
                          onRefresh: () => notifier.refresh(),
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.all(16.r),
                            // Add 1 for loading indicator at bottom
                            itemCount: products.length + 1,
                            itemBuilder: (context, index) {
                              // Show loading indicator at bottom
                              if (index == products.length) {
                                return _buildBottomLoader(productListState);
                              }

                              // Show product card
                              final product = products[index];
                              return ProductCard(
                                product: product,
                                onTap: () {
                                  _navigateToDetail(context, product.id);
                                },
                              );
                            },
                          ),
                        ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Build loading indicator at bottom of list
  Widget _buildBottomLoader(ProductState productListState) {
    // Show loader only if there are more products and currently loading
    if (productListState.hasMore && productListState.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: GlobalLoader(text: '')),
      );
    }

    // Empty spaOce (products available but not loading)
    return const SizedBox(height: 16);
  }

  void _navigateToDetail(BuildContext context, int itemId) {
    Navigation.push(
      context,
      appRoutes: AppRoutes.productDetails,
      arguments: itemId,
    );
  }
}
