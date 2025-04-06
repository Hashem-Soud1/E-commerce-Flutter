import 'package:ecommerce_app/models/add_cart_itme_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class CartService {
  Future<List<AddToCartModel>> fetchCartItems(String userId);
}

class CartServiceImpl implements CartService {
  final _firestoreService = FirestoreServices.instance;

  @override
  Future<List<AddToCartModel>> fetchCartItems(String userId) async =>
      await _firestoreService.getCollection(
        path: ApiPaths.carts(userId),
        builder: (data, documnetId) => AddToCartModel.fromMap(data),
      );
}
