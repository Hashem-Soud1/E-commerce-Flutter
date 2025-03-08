import 'package:ecommerce_app/models/product_item_model.dart';

class AddToCartModel {
  final String id;
  final ProductSize size;
  final ProductItemModel product;
  final int quantity;

  AddToCartModel({
    required this.product,
    required this.id,
    required this.size,
    required this.quantity,
  });
  double get totalPrice => product.price * quantity;

  AddToCartModel copyWith({
    String? id,
    ProductItemModel? product,
    ProductSize? size,
    int? quantity,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

List<AddToCartModel> dummyCart = [];
