import 'package:ecommerce/core/presentation/widgets/global_quantity_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_provider.dart';

import '../../../../core/presentation/widgets/global_image_loader.dart';

class CartItemCard extends ConsumerWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartProvider.notifier);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightGrey.color,
                border: Border.all(width: 1.w, color: AppColors.primary.color),
                borderRadius: BorderRadius.circular(8),
              ),

              child: GlobalImageLoader(
                imagePath: item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                imageFor: ImageFor.network,
              ),
            ),
            const SizedBox(width: 12),
            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    str: item.title,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 4),
                  GlobalText(
                    str: '\$${item.price.toStringAsFixed(2)}',
                    fontSize: 14,
                    color: AppColors.primary.color,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      GlobalQuantityBtn(
                        icon: Icons.remove,
                        onPressed: () => cartNotifier.decrementQuantity(item),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GlobalText(
                          str: '${item.quantity}',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GlobalQuantityBtn(
                        icon: Icons.add,
                        onPressed: () => cartNotifier.incrementQuantity(item),
                      ),
                      const Spacer(),
                      // Remove button
                      IconButton(
                        onPressed: () => cartNotifier.removeFromCart(item.id),
                        icon: Icon(
                          Icons.delete_outline,
                          color: AppColors.error.color,
                        ),
                        color: AppColors.error.color,
                        tooltip: 'Remove from cart',
                      ),
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
}
