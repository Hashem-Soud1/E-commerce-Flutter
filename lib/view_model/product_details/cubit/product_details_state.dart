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

final class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError(this.message);
}
