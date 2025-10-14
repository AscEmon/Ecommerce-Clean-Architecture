import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecommerce/core/di/service_locator.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce/features/cart/domain/usecases/add_to_cart.dart';
import 'package:ecommerce/features/cart/domain/usecases/get_cart_items.dart';
import 'package:ecommerce/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:ecommerce/features/cart/domain/usecases/update_cart_quantity.dart';
import 'package:ecommerce/features/cart/presentation/providers/state/cart_state.dart';

part 'cart_provider.g.dart';

/// Provider for cart state management
@riverpod
class CartNotifier extends _$CartNotifier {
  late final GetCartItems _getCartItems;
  late final AddToCart _addToCart;
  late final UpdateCartQuantity _updateCartQuantity;
  late final RemoveFromCart _removeFromCart;
  
  @override
  CartState build() {
    _getCartItems = sl<GetCartItems>();
    _addToCart = sl<AddToCart>();
    _updateCartQuantity = sl<UpdateCartQuantity>();
    _removeFromCart = sl<RemoveFromCart>();

    // Load cart items when provider is initialized
    _loadCartItems();
    
    return CartState.initial();
  }

  /// Load cart items from local storage
  Future<void> _loadCartItems() async {
    state = CartState.loading();
    
    final result = await _getCartItems(NoParams());
    
    result.fold(
      (failure) => state = CartState.error(failure.message),
      (items) => state = CartState.loaded(items),
    );
  }

  /// Add product to cart
  Future<void> addToCart(int productId, {int quantity = 1}) async {
    state = state.copyWith(isLoading: true);
    
    final result = await _addToCart(
      AddToCartParams(productId: productId, quantity: quantity),
    );
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (_) => _loadCartItems(),
    );
  }

  /// Update cart item quantity
  Future<void> updateQuantity(int cartItemId, int quantity) async {
    state = state.copyWith(isLoading: true);
    
    final result = await _updateCartQuantity(
      UpdateCartQuantityParams(cartItemId: cartItemId, quantity: quantity),
    );
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (_) => _loadCartItems(),
    );
  }

  /// Increment cart item quantity
  Future<void> incrementQuantity(CartItem item) async {
    await updateQuantity(item.id, item.quantity + 1);
  }

  /// Decrement cart item quantity
  Future<void> decrementQuantity(CartItem item) async {
    if (item.quantity > 1) {
      await updateQuantity(item.id, item.quantity - 1);
    } else {
      await removeFromCart(item.id);
    }
  }

  /// Remove item from cart
  Future<void> removeFromCart(int cartItemId) async {
    state = state.copyWith(isLoading: true);
    
    final result = await _removeFromCart(cartItemId);
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (_) => _loadCartItems(),
    );
  }
}
