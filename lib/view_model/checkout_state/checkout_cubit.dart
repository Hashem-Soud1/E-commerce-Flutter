import 'package:ecommerce_app/models/add_cart_itme_model.dart';
import 'package:ecommerce_app/models/add_new_card_model.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/services/checkout_services.dart';
import 'package:ecommerce_app/services/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getCartItems() async {
    emit(CheckoutLoading());
    try {
      final currentUser = authServices.getCurrentUser();
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

      final chosenPaymentCard =
          (await checkoutServices.fetchPaymentMethods(
            currentUser!.uid,
            true,
          )).first;
      final chosenAddress = dummyLocations.firstWhere(
        (element) => element.isChoosen == true,
        orElse: () => dummyLocations.first,
      );
      emit(
        CheckoutLoaded(
          cartItems: cartItems,
          totalAmount: subtotal + 10,
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
