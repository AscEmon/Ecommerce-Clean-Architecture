import 'product_model.dart';

class ProductResponse {
  List<ProductModel>? products;
  int? total;
  int? skip;
  int? limit;

  ProductResponse({this.products, this.total, this.skip, this.limit});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        products:
            json['products'] == null
                ? []
                : List<ProductModel>.from(
                  json['products']!.map((x) => ProductModel.fromJson(x)),
                ),
        total: json['total'],
        skip: json['skip'],
        limit: json['limit'],
      );

  Map<String, dynamic> toJson() => {
    'products':
        products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
    'total': total,
    'skip': skip,
    'limit': limit,
  };
}
