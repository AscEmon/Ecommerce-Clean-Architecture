import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/presentation/widgets/global_appbar.dart';
import 'package:ecommerce/core/presentation/widgets/global_loader.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';

import '../providers/product_details_provider.dart';
import '../widgets/product_details_content.dart';

class ProductDetailsPage extends ConsumerWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productDetailsProvider(productId));
    final notifier = ref.read(productDetailsProvider(productId).notifier);

    return Scaffold(
      appBar: GlobalAppBar(title: 'Product Details'),
      body: state.when(
        loading: () => Center(child: GlobalLoader()),
        error:
            (error, stackTrace) => const Center(
              child: GlobalText(str: 'Something went wrong. Please try again.'),
            ),
        data:
            (product) => RefreshIndicator(
              onRefresh: () => notifier.refresh(),
              child: ProductDetailsContent(product: product),
            ),
      ),
    );
  }
}
