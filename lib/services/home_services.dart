import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/home_carouesl_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProducts();
  Future<List<HomeCarouselItemModel>> fetchCarouselItems();
  Future<List<CategoryModel>> fetchCategories();
}

class HomeServicesImpl extends HomeServices {
  final _firestoreservses = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchProducts() async {
    final resualt = _firestoreservses.getCollection<ProductItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
    return resualt;
  }

  @override
  Future<List<HomeCarouselItemModel>> fetchCarouselItems() async {
    final resualt = await _firestoreservses
        .getCollection<HomeCarouselItemModel>(
          path: ApiPaths.homeCarouselItems(),
          builder: (data, documentId) => HomeCarouselItemModel.fromMap(data),
        );
    return resualt;
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final resualt = await _firestoreservses.getCollection<CategoryModel>(
      path: ApiPaths.categories(),
      builder: (data, documentId) => CategoryModel.fromMap(data),
    );
    return resualt;
  }
}
