import 'package:ecommerce_app/models/add_cart_itme_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductSize selectedSize = ProductSize.M;
  int quantity = 1;

  void fetchProductDetails(String productId) {
    emit(ProductDetailsLoading());

    Future.delayed(Duration(seconds: 1), () {
      final product = dummyProducts.firstWhere(
        (element) => element.id == productId,
      );

      emit(ProductDetailsLoaded(product));
    });
  }

  void incrementCounter(String productId) {
    quantity++;

    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String productId) {
    quantity--;

    emit(QuantityCounterLoaded(value: quantity));
  }

  void selectSize(ProductSize? size) {
    selectedSize = size!;
    emit(SizeSelected(size: selectedSize));
  }

  void addToCart(String productId) {
    emit(ProductAddingToCart());
    final cartItem = AddToCartModel(
      productId: productId,
      size: selectedSize,
      quantity: quantity,
    );

    dummyCart.add(cartItem);
    Future.delayed(const Duration(seconds: 1), () {
      emit(ProductAddedToCart(productId: productId));
    });
  }
}
