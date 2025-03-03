import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

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
    final selectedIndex = dummyProducts.indexWhere(
      (item) => item.id == productId,
    );
    dummyProducts[selectedIndex] = dummyProducts[selectedIndex].copyWith(
      quantity: dummyProducts[selectedIndex].quantity + 1,
    );
    emit(QuantityCounterLoaded(value: dummyProducts[selectedIndex].quantity));
  }

  void decrementCounter(String productId) {
    final selectedIndex = dummyProducts.indexWhere(
      (item) => item.id == productId,
    );
    dummyProducts[selectedIndex] = dummyProducts[selectedIndex].copyWith(
      quantity: dummyProducts[selectedIndex].quantity - 1,
    );
    emit(QuantityCounterLoaded(value: dummyProducts[selectedIndex].quantity));
  }

  void selectSize(ProductSize size) {
    emit(SizeSelected(size: size));
  }
}
