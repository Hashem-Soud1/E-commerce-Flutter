import 'package:ecommerce_app/models/add_cart_itme_model.dart';
import 'package:ecommerce_app/services/firebase_auth_service.dart';
import 'package:ecommerce_app/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductSize selectedSize = ProductSize.M;
  int quantity = 1;

  final _productDetailsServices = ProductDetailsServicesImpl();
  final _authServices = AuthServicesImpl();

  void fetchProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      final selectedProduct = await _productDetailsServices.fetchProductDetails(
        productId,
      );
      emit(ProductDetailsLoaded(selectedProduct));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
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

  Future<void> addToCart(String productId) async {
    emit(ProductAddingToCart());

    try {
      final selectedItem = await _productDetailsServices.fetchProductDetails(
        productId,
      );

      final cartItem = AddToCartModel(
        product: selectedItem,
        id: DateTime.now().toIso8601String(),
        quantity: quantity,
        size: selectedSize,
      );

      final userId = _authServices.getCurrentUser()!.uid;

      await _productDetailsServices.addToCart(cartItem, userId);

      emit(ProductAddedToCart(productId: productId));
    } catch (e) {
      emit(ProductAddToCartError(e.toString()));
    }
  }
}
