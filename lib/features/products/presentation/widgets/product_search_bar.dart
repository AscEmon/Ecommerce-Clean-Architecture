import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';
import 'package:ecommerce/core/presentation/widgets/global_text_form_field.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/product_provider.dart';

class ProductSearchBar extends ConsumerStatefulWidget {
  const ProductSearchBar({super.key});

  @override
  ConsumerState<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends ConsumerState<ProductSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _showClearButton = _searchController.text.isNotEmpty;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(productProvider.notifier).searchProducts(null);
    _searchFocusNode.unfocus();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      ref.read(productProvider.notifier).searchProducts(null);
    } else {
      ref.read(productProvider.notifier).searchProducts(query);
    }
    _searchFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Row(
        children: [
          Expanded(
            child: GlobalTextFormField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon:
                  _showClearButton
                      ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                      : null,
              onFieldSubmitted: (_) => _performSearch(),
              textInputAction: TextInputAction.search,
            ),
          ),
          SizedBox(width: 8.w),
          ElevatedButton(
            onPressed: _performSearch,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary.color,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: GlobalText(str: 'Search', color: AppColors.white.color),
          ),
        ],
      ),
    );
  }
}
