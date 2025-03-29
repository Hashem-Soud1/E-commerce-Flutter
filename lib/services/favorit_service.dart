import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class FavoritService {
  Future<List<ProductItemModel>> fetchFavoriteProducts(String userId);
  Future<void> addProductToFavorite(String userId, ProductItemModel product);
  Future<void> removeProductFromFavorite(String userId, String productId);
}

class FavoriteServiceImp extends FavoritService {
  final _firestoreservses = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchFavoriteProducts(String userId) async {
    final result = await _firestoreservses.getCollection<ProductItemModel>(
      path: ApiPaths.favoriteProducts(userId),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<void> addProductToFavorite(
    String userId,
    ProductItemModel product,
  ) async => await _firestoreservses.setData(
    path: ApiPaths.favoriteProduct(userId, product.id),
    data: product.toMap(),
  );

  @override
  Future<void> removeProductFromFavorite(
    String userId,
    String productId,
  ) async {
    await _firestoreservses.deleteData(
      path: ApiPaths.favoriteProduct(userId, productId),
    );
  }
}
