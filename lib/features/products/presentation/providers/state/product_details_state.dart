import 'package:equatable/equatable.dart';
import 'package:ecommerce/features/products/domain/entities/product.dart';

class ProductDetailsState extends Equatable {
  final Product? product;

  const ProductDetailsState({this.product});

  ProductDetailsState copyWith({Product? product}) {
    return ProductDetailsState(product: product ?? this.product);
  }

  @override
  List<Object?> get props => [product];
}
