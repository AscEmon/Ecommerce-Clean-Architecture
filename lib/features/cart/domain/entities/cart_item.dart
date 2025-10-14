import 'package:equatable/equatable.dart';

/// Domain entity for cart item
class CartItem extends Equatable {
  final int id;
  final int productId;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  const CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({
    int? id,
    int? productId,
    String? title,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, productId, title, imageUrl, price, quantity];
}
