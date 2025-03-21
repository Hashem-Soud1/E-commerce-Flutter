import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProducts();
}

class HomeServicesImpl extends HomeServices {
  final _firestoreservses = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchProducts() async {
    final resualt = _firestoreservses.getCollection<ProductItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
    );
    return resualt;
  }
}
