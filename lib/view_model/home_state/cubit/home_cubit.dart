import 'package:ecommerce_app/services/favorit_service.dart';
import 'package:ecommerce_app/services/firebase_auth_service.dart';
import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/home_carouesl_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final _homeService = HomeServicesImpl();
  final _authService = AuthServicesImpl();
  final _favoriteProducts = FavoriteServiceImp();

  Future<void> fetchHomeData() async {
    emit(HomeLoading());

    try {
      final products = await _homeService.fetchProducts();
      final carouselItems = await _homeService.fetchCarouselItems();
      final favProducts = await _favoriteProducts.fetchFavoriteProducts(
        _authService.getCurrentUser()!.uid,
      );

      final finalProducts =
          products.map((e) {
            final isFav = favProducts.any((item) => item.id == e.id);
            return e.copyWith(isFavorite: isFav);
          }).toList();

      emit(HomeLoaded(carouselItems: carouselItems, products: finalProducts));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> setFavorite(ProductItemModel product) async {
    emit(SetFavoriteLoading(productId: product.id));
    try {
      final currentUser = _authService.getCurrentUser();
      final List<ProductItemModel> currentFav = await _favoriteProducts
          .fetchFavoriteProducts(currentUser!.uid);

      final isFavorite = currentFav.any((element) => element.id == product.id);

      if (!isFavorite) {
        await _favoriteProducts.addProductToFavorite(currentUser.uid, product);
      } else {
        await _favoriteProducts.removeProductFromFavorite(
          currentUser.uid,
          product.id,
        );
      }
      emit(SetFavoriteSuccess(isFavorite: !isFavorite, productId: product.id));
    } catch (e) {
      emit(SetFavoriteError(e.toString(), product.id));
    }
  }
}
