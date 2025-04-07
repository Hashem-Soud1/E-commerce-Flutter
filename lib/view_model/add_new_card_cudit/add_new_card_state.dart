part of 'add_new_card_cubit.dart';

sealed class PaymentMethodsState {}

final class AddNewCardInitial extends PaymentMethodsState {}

final class AddNewCardLoading extends PaymentMethodsState {}

final class AddNewCardSuccess extends PaymentMethodsState {}

final class AddNewCardFailure extends PaymentMethodsState {
  final String errorMessage;

  AddNewCardFailure(this.errorMessage);
}

final class FetchingPaymentMethods extends PaymentMethodsState {}

final class FetchedPaymentMethods extends PaymentMethodsState {
  final List<PaymentCardModel> paymentCards;

  FetchedPaymentMethods(this.paymentCards);
}

final class FetchPaymentMethodsError extends PaymentMethodsState {
  final String errorMessage;

  FetchPaymentMethodsError(this.errorMessage);
}

final class PaymentCardChosenLoded extends PaymentMethodsState {
  final PaymentCardModel paymentCardChosen;

  PaymentCardChosenLoded(this.paymentCardChosen);
}

final class ConfirmPaymentMethodLoading extends PaymentMethodsState {}

final class ConfirmPaymentMethodLoded extends PaymentMethodsState {
  ConfirmPaymentMethodLoded();
}

final class ConfirmPaymentMethodError extends PaymentMethodsState {
  final String message;

  ConfirmPaymentMethodError(this.message);
}
