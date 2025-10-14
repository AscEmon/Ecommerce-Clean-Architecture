import 'package:ecommerce/features/cart/domain/entities/cart_item.dart';

/// Data model for cart item
class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.productId,
    required super.title,
    required super.imageUrl,
    required super.price,
    required super.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as int,
      productId: json['productId'] as int,
      title: json['title'] as String,
      imageUrl: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'image': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }
}
