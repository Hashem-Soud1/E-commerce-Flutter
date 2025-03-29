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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'size': size.name,
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'] as String,
      size: ProductSize.fromMap(map['size']),
      product: ProductItemModel.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }
}

List<AddToCartModel> dummyCart = [
  AddToCartModel(
    id: '1',
    size: ProductSize.S,
    quantity: 1,
    product: ProductItemModel(
      id: '1',
      name: 'Nike Air Max 270',
      price: 150,
      description:
          'The Nike Air Max 270 delivers visible air under every step. Updated for modern comfort, it nods to the original 1991 Air Max 180 with its exaggerated tongue top and heritage tongue logo.',
      category: 'shoes',
      imgUrl:
          'https://www.pngall.com/wp-content/uploads/2016/09/Trouser-Free-Download-PNG.png',
    ),
  ),
];
