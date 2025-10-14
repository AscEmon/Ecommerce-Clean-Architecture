import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:ecommerce/features/products/domain/entities/product.dart';

import '../../../../core/presentation/widgets/global_quantity_btn.dart';


/// Widget to display add to cart button or quantity controls
class CartQuantityControl extends ConsumerWidget {
  final Product product;

  const CartQuantityControl({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    // Check if product is in cart
    final bool isInCart = cartState.hasProduct(product.id);
    CartItem? cartItem;

    if (isInCart) {
      try {
        cartItem = cartState.getCartItemByProductId(product.id);
      } catch (e) {
        // Product not found in cart
      }
    }

    if (cartItem != null) {
      // Show quantity controls if product is in cart
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlobalQuantityBtn(
            icon: Icons.remove,
            onPressed: () => cartNotifier.decrementQuantity(cartItem!),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: GlobalText(
              str: '${cartItem.quantity}',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          GlobalQuantityBtn(
            icon: Icons.add,
            onPressed: () => cartNotifier.incrementQuantity(cartItem!),
          ),
        ],
      );
    } else {
      // Show add to cart button if product is not in cart
      return ElevatedButton.icon(
        onPressed: () => cartNotifier.addToCart(product.id),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary.color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        icon: const Icon(Icons.add_shopping_cart),
        label: GlobalText(
          str: 'Add to Cart',
          fontSize: 12,
          color: AppColors.white.color,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
