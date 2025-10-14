import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/features/products/domain/entities/product.dart';
import 'package:ecommerce/features/products/presentation/widgets/cart_quantity_control.dart';

class ProductDetailsCartButton extends StatelessWidget {
  final Product product;

  const ProductDetailsCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Price information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GlobalText(
                  str: '\$${product.price.toStringAsFixed(2)}',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary.color,
                ),
                if (product.discountPercentage > 0)
                  Row(
                    children: [
                      GlobalText(
                        str: '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // Use the same cart quantity control as in product list
          CartQuantityControl(product: product),
        ],
      ),
    );
  }
}
