import 'package:ecommerce_app/services/favorit_service.dart';
import 'package:ecommerce_app/services/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'favorite_page_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  final favoriteServices = FavoriteServiceImp();
  final authServices = AuthServicesImpl();

  Future<void> getFavoriteProducts() async {
    emit(FavoriteLoading());
    try {
      final currentUser = authServices.getCurrentUser();
      final favoriteProducts = await favoriteServices.fetchFavoriteProducts(
        currentUser!.uid,
      );
      emit(FavoriteLoaded(favoriteProducts));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> removeFavorite(String productId) async {
    emit(FavoriteRemoveLoading(productId));
    try {
      final currentUser = authServices.getCurrentUser();
      await favoriteServices.removeProductFromFavorite(
        currentUser!.uid,
        productId,
      );
      emit(FavoriteRemoveLoaded(productId));

      final favoriteProducts = await favoriteServices.fetchFavoriteProducts(
        currentUser.uid,
      );
      emit(FavoriteLoaded(favoriteProducts));
    } catch (e) {
      emit(FavoriteRemoveError(e.toString(), productId));
    }
  }
}
