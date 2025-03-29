part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<HomeCarouselItemModel> carouselItems;
  final List<ProductItemModel> products;

  HomeLoaded({required this.carouselItems, required this.products});
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

final class SetFavoriteLoading extends HomeState {
  final String productId;
  SetFavoriteLoading({required this.productId});
}

final class SetFavoriteSuccess extends HomeState {
  final bool isFavorite;
  final String productId;

  SetFavoriteSuccess({required this.isFavorite, required this.productId});
}

final class SetFavoriteError extends HomeState {
  SetFavoriteError(this.message, this.productId);

  final String productId;
  final String message;
}
