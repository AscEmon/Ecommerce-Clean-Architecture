import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:ecommerce/features/products/presentation/pages/product_page.dart';
import 'package:ecommerce/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:ecommerce/features/dashboard/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:ecommerce/features/dashboard/presentation/widgets/custom_drawer.dart';

import '../../../../core/presentation/widgets/global_appbar.dart';
import '../../../../core/theme/theme_manager.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(dashboardProviderProvider);

    // List of pages for each tab
    // Home tab reuses existing ProductPage
    final List<Widget> pages = [const ProductPage(), const CartPage()];

    return Scaffold(
      appBar: GlobalAppBar(
        title: currentIndex == 0 ? 'Products' : 'Cart',
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              ThemeManager().isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              ThemeManager().toggleTheme();
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
