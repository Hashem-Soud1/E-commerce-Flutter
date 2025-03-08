import 'package:ecommerce_app/models/add_cart_itme_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void getCartItems() {
    emit(CheckoutLoading());
    final cartItems = dummyCart;
    final subtotal = cartItems.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element.product.price * element.quantity),
    );
    final numOfProducts = cartItems.fold(
      0,
      (previousValue, element) => previousValue + element.quantity,
    );
    emit(
      CheckoutLoaded(
        cartItems: cartItems,
        totalAmount: subtotal + 10,
        numOfProducts: numOfProducts,
      ),
    );
  }
}
