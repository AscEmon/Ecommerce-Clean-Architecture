import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/presentation/view_util.dart';
import 'package:ecommerce/core/presentation/widgets/global_loader.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_item_card.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    if (cartState.isLoading) {
      return const Center(child: GlobalLoader(text: 'Loading cart...'));
    }

    if (cartState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            GlobalText(
              str: 'Error: ${cartState.error}',
              fontSize: 16,
              color: Colors.red,
            ),
          ],
        ),
      );
    }

    if (cartState.items.isEmpty) {
      return _EmptyCart();
    }

    return _CartContent(items: cartState.items);
  }
}

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 72,
            color: AppColors.textSecondary.color,
          ),
          const SizedBox(height: 16),
          GlobalText(
            str: 'Your cart is empty',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary.color,
          ),
          const SizedBox(height: 8),
          GlobalText(
            str: 'Add items to your cart to see them here',
            fontSize: 14,
            color: AppColors.textSecondary.color,
          ),
        ],
      ),
    );
  }
}

class _CartContent extends StatelessWidget {
  final List<CartItem> items;

  const _CartContent({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return CartItemCard(item: item);
            },
          ),
        ),
        _CartSummary(items: items),
      ],
    );
  }
}

class _CartSummary extends ConsumerWidget {
  final List<CartItem> items;

  const _CartSummary({required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPrice = items.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.primary.color),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const GlobalText(
                str: 'Total:',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              GlobalText(
                str: '\$${totalPrice.toStringAsFixed(2)}',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary.color,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ViewUtil.snackbar('Checkout not implemented yet');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary.color,
                foregroundColor: AppColors.white.color,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: GlobalText(
                str: 'Checkout',
                fontSize: 16,
                color: AppColors.white.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
