part of 'add_new_card_cubit.dart';

sealed class AddNewCardState {}

final class AddNewCardInitial extends AddNewCardState {}

final class AddNewCardLoading extends AddNewCardState {}

final class AddNewCardLoded extends AddNewCardState {
  final PaymentCardModel addNewCardModel;

  AddNewCardLoded({required this.addNewCardModel});
}

final class AddNewCardError extends AddNewCardState {
  final String message;

  AddNewCardError(this.message);
}

final class PaymentCardLoading extends AddNewCardState {}

final class PyamentCardLoded extends AddNewCardState {
  final List<PaymentCardModel> paymentCards;

  PyamentCardLoded({required this.paymentCards});
}

final class PaymentCardError extends AddNewCardState {
  final String message;

  PaymentCardError(this.message);
}
