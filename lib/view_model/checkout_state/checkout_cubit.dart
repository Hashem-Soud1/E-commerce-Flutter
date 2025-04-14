import 'package:ecommerce_app/models/add_cart_itme_model.dart';
import 'package:ecommerce_app/models/add_new_card_model.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/services/cart_service.dart';
import 'package:ecommerce_app/services/checkout_services.dart';
import 'package:ecommerce_app/services/firebase_auth_service.dart';
import 'package:ecommerce_app/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImpl();
  final locationServices = LocationServicesImpl();
  final cartServices = CartServiceImpl();

  Future<void> getCheckoutContent() async {
    emit(CheckoutLoading());
    try {
      final currentUser = authServices.getCurrentUser();
      final cartItems = await cartServices.fetchCartItems(currentUser!.uid);
      double shippingValue = 10;
      final subtotal = cartItems.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.product.price * element.quantity),
      );
      final numOfProducts = cartItems.fold(
        0,
        (previousValue, element) => previousValue + element.quantity,
      );

      final chosenPaymentCard =
          (await checkoutServices.fetchPaymentMethods(
            currentUser.uid,
            true,
          )).first;
      final chosenAddress =
          (await locationServices.fetchLocations(currentUser.uid, true)).first;
      emit(
        CheckoutLoaded(
          cartItems: cartItems,
          totalAmount: subtotal + shippingValue,
          subtotal: subtotal,
          shippingValue: shippingValue,
          numOfProducts: numOfProducts,
          CardChoosen: chosenPaymentCard,
          LocationChoosen: chosenAddress,
        ),
      );
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }
}
