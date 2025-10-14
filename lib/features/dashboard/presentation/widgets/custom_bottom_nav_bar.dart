import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:ecommerce/features/dashboard/presentation/providers/dashboard_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(dashboardProviderProvider);
        final cartState = ref.watch(cartProvider);
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            ref.read(dashboardProviderProvider.notifier).setTab(index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary.color,
          unselectedItemColor: AppColors.textSecondary.color,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Badge.count(
                count: cartState.items.length,
                child: Icon(Icons.shopping_cart_outlined),
              ),
              activeIcon: Badge.count(
                count: cartState.items.length,
                child: Icon(Icons.shopping_cart),
              ),
              label: 'Cart',
            ),
          ],
        );
      },
    );
  }
}
