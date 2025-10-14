import 'package:flutter/material.dart';
import 'package:ecommerce/core/presentation/widgets/global_image_loader.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';
import '../../domain/entities/product.dart';
import '../../../../core/theme/app_colors.dart';
import 'cart_quantity_control.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image at the top
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey.color.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Center(
                child: GlobalImageLoader(
                  imagePath: product.images.firstOrNull ?? '',
                  height: 180,
                  imageFor: ImageFor.network,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: GlobalText(
                      str: product.category.toUpperCase(),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 10,
                        child: GlobalText(
                          str: product.title,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      GlobalText(
                        str: '\$${product.price.toStringAsFixed(2)}',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary.color,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Content preview
                  GlobalText(
                    str: _truncateContent(product.description),
                    fontSize: 14,
                    color: AppColors.textSecondary.color,
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GlobalText(
                            str: 'Read more',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary.color,
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: AppColors.primary.color,
                          ),
                        ],
                      ),

                      CartQuantityControl(product: product),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to truncate content
  String _truncateContent(String content) {
    if (content.length <= 100) return content;
    return '${content.substring(0, 100)}...';
  }
}
