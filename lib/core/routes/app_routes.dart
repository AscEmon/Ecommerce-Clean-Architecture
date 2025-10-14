import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/products/presentation/pages/product_page.dart';
import '../../features/products/presentation/pages/product_details_page.dart';

enum AppRoutes { login, mainContainer, product, productDetails }

extension AppRoutesExtention on AppRoutes {
  Widget buildWidget<T extends Object>({T? arguments}) {
    switch (this) {
      case AppRoutes.login:
        return const LoginPage();
      case AppRoutes.mainContainer:
        return const DashboardPage();
      case AppRoutes.product:
        return const ProductPage();
      case AppRoutes.productDetails:
        if (arguments is int) {
          return ProductDetailsPage(productId: arguments);
        }
    }
    return const SizedBox();
  }
}
