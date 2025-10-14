import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../products/domain/entities/product.dart';
import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  /// Gets the cached list of cart items
  ///
  /// Throws [CacheException] if no cached data is present
  Future<List<CartItemModel>> getCartItems();

  /// Adds a product to the cart
  ///
  /// Returns the updated list of cart items
  Future<void> addToCart(Product product, int quantity);

  /// Updates the quantity of a cart item
  ///
  /// Returns the updated list of cart items
  Future<void> updateQuantity(int cartItemId, int quantity);

  /// Removes a cart item
  ///
  /// Returns the updated list of cart items
  Future<void> removeFromCart(int cartItemId);

  /// Clears the cart
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final jsonString = sharedPreferences.getString(
      AppConstants.cashCartItems.key,
    );
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((item) => CartItemModel.fromJson(item)).toList();
    } else {
      // Return empty list instead of throwing exception for better UX
      return [];
    }
  }

  @override
  Future<void> addToCart(Product product, int quantity) async {
    final cartItems = await getCartItems();

    // Check if product already exists in cart
    final existingItemIndex = cartItems.indexWhere(
      (item) => item.productId == product.id,
    );

    if (existingItemIndex >= 0) {
      // Update quantity if product already in cart
      final existingItem = cartItems[existingItemIndex];
      cartItems[existingItemIndex] = CartItemModel(
        id: existingItem.id,
        productId: existingItem.productId,
        title: existingItem.title,
        imageUrl: existingItem.imageUrl,
        price: existingItem.price,
        quantity: existingItem.quantity + quantity,
      );
    } else {
      // Add new item to cart
      final newId = cartItems.isEmpty
          ? 1
          : cartItems.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;

      cartItems.add(
        CartItemModel(
          id: newId,
          productId: product.id,
          title: product.title,
          imageUrl: product.thumbnail,
          price: product.price,
          quantity: quantity,
        ),
      );
    }

    // Save updated cart
    await _saveCartItems(cartItems);
  }

  @override
  Future<void> updateQuantity(int cartItemId, int quantity) async {
    final cartItems = await getCartItems();
    final itemIndex = cartItems.indexWhere((item) => item.id == cartItemId);

    if (itemIndex >= 0) {
      if (quantity <= 0) {
        // Remove item if quantity is 0 or less
        await removeFromCart(cartItemId);
      } else {
        // Update quantity
        final item = cartItems[itemIndex];
        cartItems[itemIndex] = CartItemModel(
          id: item.id,
          productId: item.productId,
          title: item.title,
          imageUrl: item.imageUrl,
          price: item.price,
          quantity: quantity,
        );

        await _saveCartItems(cartItems);
      }
    } else {
      throw CacheException(message: 'Cart item not found');
    }
  }

  @override
  Future<void> removeFromCart(int cartItemId) async {
    final cartItems = await getCartItems();
    final updatedItems = cartItems
        .where((item) => item.id != cartItemId)
        .toList();
    await _saveCartItems(updatedItems);
  }

  @override
  Future<void> clearCart() async {
    await sharedPreferences.remove(AppConstants.cashCartItems.key);
  }

  /// Helper method to save cart items to shared preferences
  Future<void> _saveCartItems(List<CartItemModel> cartItems) async {
    final jsonList = cartItems.map((item) => item.toJson()).toList();
    await sharedPreferences.setString(
      AppConstants.cashCartItems.key,
      json.encode(jsonList),
    );
  }
}
