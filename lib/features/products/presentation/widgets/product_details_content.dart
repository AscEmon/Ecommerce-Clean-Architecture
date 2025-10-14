import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/core/presentation/widgets/global_image_loader.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/core/theme/theme_manager.dart';
import 'package:ecommerce/features/products/domain/entities/product.dart';
import 'package:ecommerce/features/products/presentation/widgets/cart_quantity_control.dart';

import 'info_row.dart';

class ProductDetailsContent extends StatelessWidget {
  final Product product;

  const ProductDetailsContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          if (product.images.isNotEmpty)
            GlobalImageLoader(
              imagePath: product.images.first,
              imageFor: ImageFor.network,
              height: 300.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                GlobalText(
                  str: product.title,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),

                SizedBox(height: 12.h),

                // Category Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.color.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: GlobalText(str: product.category, fontSize: 12),
                ),

                SizedBox(height: 16.h),

                // Status
                Row(
                  children: [
                    const GlobalText(
                      str: 'Status: ',
                      fontWeight: FontWeight.w600,
                    ),
                    GlobalText(
                      str: product.availabilityStatus,
                      color:
                          product.availabilityStatus.toLowerCase() ==
                                  'published'
                              ? AppColors.green.color
                              : AppColors.orange.color,
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Divider
                Divider(height: 1.h, color: Colors.grey.shade300),

                SizedBox(height: 24.h),

                // Content
                const GlobalText(
                  str: 'Description',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),

                SizedBox(height: 12.h),

                GlobalText(str: product.description, fontSize: 14, height: 1.5),

                SizedBox(height: 24.h),

                // Additional Info
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color:
                        ThemeManager().isDarkMode
                            ? AppColors.greylish.color
                            : AppColors.cardBackground.color,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GlobalText(
                        str: 'Additional Information',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 12.h),
                      InfoRow(
                        label: 'Product ID',
                        value: product.id.toString(),
                      ),
                      SizedBox(height: 8.h),
                      InfoRow(label: 'Slug', value: product.sku),
                      SizedBox(height: 8.h),
                      InfoRow(
                        label: 'Minimum Order Quantity',
                        value: product.minimumOrderQuantity.toString(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),
                // Price and Cart Controls
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color:
                        ThemeManager().isDarkMode
                            ? AppColors.greylish.color
                            : AppColors.cardBackground.color,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      // Price information
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalText(
                              str: '\$${product.price.toStringAsFixed(2)}',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary.color,
                            ),
                            if (product.discountPercentage > 0)
                              GlobalText(
                                str:
                                    '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                          ],
                        ),
                      ),
                      // Cart controls
                      CartQuantityControl(product: product),
                    ],
                  ),
                ),

                // Add extra padding at the bottom for the cart button
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
