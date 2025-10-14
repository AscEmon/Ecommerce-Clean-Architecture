import '/features/products/domain/entities/product.dart';

/// Model class for Product that extends the domain entity
class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    super.brand,
    required super.sku,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required super.images,
    required super.thumbnail,
  });

  /// Create a ProductModel from JSON (single product from DummyJSON)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'] as int,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      brand: json['brand'] as String?,
      sku: json['sku'] as String,
      // weight: json['weight'], ← Ignored (not in entity)
      // dimensions: json['dimensions'], ← Ignored (not in entity)
      warrantyInformation: json['warrantyInformation'] as String,
      shippingInformation: json['shippingInformation'] as String,
      availabilityStatus: json['availabilityStatus'] as String,
      // reviews: json['reviews'], ← Ignored (not in entity)
      returnPolicy: json['returnPolicy'] as String,
      minimumOrderQuantity: json['minimumOrderQuantity'] as int,
      // meta: json['meta'], ← Ignored (not in entity)
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      thumbnail: json['thumbnail'] as String,
    );
  }

  /// Convert ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}
