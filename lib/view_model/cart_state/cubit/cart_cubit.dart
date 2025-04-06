import 'package:ecommerce_app/models/add_cart_itme_model.dart';
import 'package:ecommerce_app/services/cart_service.dart';
import 'package:ecommerce_app/services/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  final _cartService = CartServiceImpl();
  final _authService = AuthServicesImpl();

  void getCartItems() async {
    emit(CartLoading());
    try {
      final currentuser = _authService.getCurrentUser();
      final cartItems = await _cartService.fetchCartItems(currentuser!.uid);
      final subtotal = cartItems.fold<double>(
        0,
        (previousValue, item) =>
            previousValue + (item.product.price * item.quantity),
      );

      emit(CartLoaded(cartItems, subtotal));
    } catch (e) {
      emit(CartError('Failed to load cart items'));
    }
  }

  void incrementCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    final index = dummyCart.indexWhere((item) => item.product.id == productId);
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
    emit(QuantityCounterLoaded(value: quantity, productId: productId));
    emit(SubtotalUpdated(_subtotal));
  }

  void decrementCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity--;
    final index = dummyCart.indexWhere((item) => item.product.id == productId);
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
    emit(QuantityCounterLoaded(value: quantity, productId: productId));
    emit(SubtotalUpdated(_subtotal));
  }

  double get _subtotal => dummyCart.fold<double>(
    0,
    (previousValue, item) =>
        previousValue + (item.product.price * item.quantity),
  );
}
