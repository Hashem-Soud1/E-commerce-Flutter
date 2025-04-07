import 'package:ecommerce_app/models/add_new_card_model.dart';
import 'package:ecommerce_app/services/checkout_services.dart';
import 'package:ecommerce_app/services/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_card_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(AddNewCardInitial());

  String? selectedPaymentId;
  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> addNewCard(
    String cardNumber,
    String cardHolderName,
    String expiryDate,
    String cvv,
  ) async {
    emit(AddNewCardLoading());
    try {
      final newCard = PaymentCardModel(
        id: DateTime.now().toIso8601String(),
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        expiryDate: expiryDate,
        cvvCode: cvv,
      );
      final currentUser = authServices.getCurrentUser();
      await checkoutServices.setCard(currentUser!.uid, newCard);
      emit(AddNewCardSuccess());
    } catch (e) {
      emit(AddNewCardFailure(e.toString()));
    }
  }

  Future<void> fetchPaymentMethods() async {
    emit(FetchingPaymentMethods());
    try {
      final currentUser = authServices.getCurrentUser();
      final paymentCards = await checkoutServices.fetchPaymentMethods(
        currentUser!.uid,
      );
      emit(FetchedPaymentMethods(paymentCards));
      if (paymentCards.isNotEmpty) {
        final chosenPaymentMethod = paymentCards.firstWhere(
          (element) => element.isChosen,
          orElse: () => paymentCards.first,
        );
        selectedPaymentId = chosenPaymentMethod.id;
        emit(PaymentCardChosenLoded(chosenPaymentMethod));
      }
    } catch (e) {
      emit(FetchPaymentMethodsError(e.toString()));
    }
  }

  Future<void> changePaymentMethod(String id) async {
    selectedPaymentId = id;
    try {
      final currentUser = authServices.getCurrentUser();
      final tempChosenPaymentMethod = await checkoutServices
          .fetchSinglePaymentMethod(currentUser!.uid, selectedPaymentId!);
      emit(PaymentCardChosenLoded(tempChosenPaymentMethod));
    } catch (e) {
      emit(FetchPaymentMethodsError(e.toString()));
    }
  }

  Future<void> confirmPaymentMethod() async {
    emit(ConfirmPaymentMethodLoading());

    try {
      final currentUser = authServices.getCurrentUser();
      final previousChosenPayment = await checkoutServices.fetchPaymentMethods(
        currentUser!.uid,
        true,
      );
      final previousChosenPaymentMethod = previousChosenPayment.first.copyWith(
        isChosen: false,
      );
      var chosenPaymentMethod = await checkoutServices.fetchSinglePaymentMethod(
        currentUser.uid,
        selectedPaymentId!,
      );
      chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);
      await checkoutServices.setCard(
        currentUser.uid,
        previousChosenPaymentMethod,
      );
      await checkoutServices.setCard(currentUser.uid, chosenPaymentMethod);
      emit(ConfirmPaymentMethodLoded());
    } catch (e) {
      emit(ConfirmPaymentMethodError(e.toString()));
    }
  }
}
