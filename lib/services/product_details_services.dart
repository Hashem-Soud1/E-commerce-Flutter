import 'package:ecommerce_app/models/add_cart_itme_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> fetchProductDetails(String productId);
  Future<void> addToCart(AddToCartModel cartModel, String userId);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final _firestore = FirestoreServices.instance;
  @override
  Future<ProductItemModel> fetchProductDetails(String productId) async {
    final selectedProduct = await _firestore.getDocument(
      path: ApiPaths.product(productId),
      builder: (data, documentId) {
        return ProductItemModel.fromMap(data);
      },
    );
    return selectedProduct;
  }

  @override
  Future<void> addToCart(AddToCartModel cartItem, String userId) async {
    await _firestore.setData(
      path: ApiPaths.cart(userId, cartItem.id),
      data: cartItem.toMap(),
    );
  }
}
