import 'package:equatable/equatable.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item.dart';

/// State for cart feature
class CartState extends Equatable {
  final List<CartItem> items;
  final bool isLoading;
  final String? error;

  const CartState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  /// Get total price of all items in cart
  double get totalPrice => items.fold(
        0,
        (total, item) => total + (item.price * item.quantity),
      );

  /// Get total number of items in cart
  int get itemCount => items.fold(
        0,
        (total, item) => total + item.quantity,
      );

  /// Check if cart contains a specific product
  bool hasProduct(int productId) => 
      items.any((item) => item.productId == productId);

  /// Get cart item for a specific product
  CartItem? getCartItemByProductId(int productId) =>
      items.firstWhere(
        (item) => item.productId == productId,
        orElse: () => throw Exception('Product not found in cart'),
      );

  /// Create a copy of this state with given parameters
  CartState copyWith({
    List<CartItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  /// Initial state
  factory CartState.initial() => const CartState();

  /// Loading state
  factory CartState.loading() => const CartState(isLoading: true);

  /// Error state
  factory CartState.error(String message) => CartState(error: message);

  /// Loaded state
  factory CartState.loaded(List<CartItem> items) => CartState(items: items);

  @override
  List<Object?> get props => [items, isLoading, error];
}
