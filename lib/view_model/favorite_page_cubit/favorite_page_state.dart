part of 'favorite_page_cubit.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  final List<ProductItemModel> favoriteProducts;

  FavoriteLoaded(this.favoriteProducts);
}

final class FavoriteError extends FavoriteState {
  final String error;

  FavoriteError(this.error);
}

final class FavoriteRemoveLoading extends FavoriteState {
  final String productId;
  FavoriteRemoveLoading(this.productId);
}

final class FavoriteRemoveLoaded extends FavoriteState {
  final String productId;

  FavoriteRemoveLoaded(this.productId);
}

final class FavoriteRemoveError extends FavoriteState {
  final String error;
  final String productId;
  FavoriteRemoveError(this.productId, this.error);
}
