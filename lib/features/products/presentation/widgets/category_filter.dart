import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/core/utils/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/widgets/global_dropdown.dart';
import '../providers/product_provider.dart';

class CategoryFilter extends ConsumerWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productNotifier = ref.read(productProvider.notifier);
    final productState = ref.watch(productProvider);

    // Create a local variable to determine what to display in the dropdown
    final selectedCategory = productState.requireValue.selectedCategory;

    // Log the current category for debugging
    'Current category in UI: $selectedCategory'.log();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalText(
            str: 'Filter by Category',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8.h),
          // Force rebuild of dropdown when category changes by using a key
          GlobalDropdown<String>(
            key: UniqueKey(), // Use UniqueKey to force rebuild every time
            validator: (value) => null,
            hintText: 'Select Category',
            value: selectedCategory,
            onChanged: (newValue) {
              if (newValue != null) {
                // Apply category filter
                if (newValue == _categories.first) {
                  productNotifier.setSelectedCategory(null);
                } else {
                  productNotifier.setSelectedCategory(newValue);
                }
              }
            },
            items:
                _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: GlobalText(str: category),
                  );
                }).toList(),
          ),
          SizedBox(height: 8.h),
          if (productState.asData?.value.hasFilters == true) ...[
            TextButton.icon(
              onPressed: () {
                // First explicitly set the category to null
                productNotifier.setSelectedCategory(null);
                // Then clear all filters
                productNotifier.clearFilters();
              },
              icon: Icon(Icons.clear, color: AppColors.primary.color),
              label: GlobalText(
                str: 'Clear Filters',
                color: AppColors.primary.color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

final List<String> _categories = [
  'All Categories',
  'smartphones',
  'laptops',
  'fragrances',
  'skincare',
  'groceries',
  'home-decoration',
  'furniture',
  'tops',
  'womens-dresses',
  'womens-shoes',
  'mens-shirts',
  'mens-shoes',
  'mens-watches',
  'womens-watches',
  'womens-bags',
  'womens-jewellery',
  'sunglasses',
  'automotive',
  'motorcycle',
  'lighting',
];
