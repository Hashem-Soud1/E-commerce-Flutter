part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;
  ProductDetailsLoaded(this.product);
}

final class QuantityCounterLoaded extends ProductDetailsState {
  final int value;
  QuantityCounterLoaded({required this.value});
}

final class SizeSelected extends ProductDetailsState {
  final ProductSize size;
  SizeSelected({required this.size});
}

final class ProductAddingToCart extends ProductDetailsState {}

final class ProductAddedToCart extends ProductDetailsState {
  final String productId;
  ProductAddedToCart({required this.productId});
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError(this.message);
}

final class ProductAddToCartError extends ProductDetailsState {
  final String message;
  ProductAddToCartError(this.message);
}
