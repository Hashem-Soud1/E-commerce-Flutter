import 'package:ecommerce_app/models/add_new_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_card_state.dart';

class AddNewCardCubit extends Cubit<AddNewCardState> {
  AddNewCardCubit() : super(AddNewCardInitial());

  String selectedPaymentId = dummyPaymentCards.first.id;

  void addNewCard(PaymentCardModel addNewCardModel) {
    emit(AddNewCardLoading());

    Future.delayed(Duration(seconds: 1), () {
      dummyPaymentCards.add(addNewCardModel);
      emit(AddNewCardLoded(addNewCardModel: addNewCardModel));
    });
  }

  void fetchPaymentMethods() {
    emit(PaymentCardLoading());
    Future.delayed(const Duration(seconds: 1), () {
      if (dummyPaymentCards.isNotEmpty) {
        final chosenPaymentMethod = dummyPaymentCards.firstWhere(
          (paymentCards) => paymentCards.isChosen == true,
          orElse: () => dummyPaymentCards.first,
        );
        emit(PyamentCardLoded(dummyPaymentCards));
        emit(PaymentCardChosenLoded(chosenPaymentMethod));
      } else {
        emit(PaymentCardError('No payment methods found'));
      }
    });
  }

  void changePaymentMethod(String id) {
    selectedPaymentId = id;
    var tempChosenPaymentMethod = dummyPaymentCards.firstWhere(
      (paymentCard) => paymentCard.id == selectedPaymentId,
    );
    emit(PaymentCardChosenLoded(tempChosenPaymentMethod));
  }

  void confirmPaymentMethod() {
    emit(ConfirmPaymentMethodLoading());

    Future.delayed(const Duration(seconds: 1), () {
      var chosenPaymentMethod = dummyPaymentCards.firstWhere(
        (paymentCard) => paymentCard.id == selectedPaymentId,
      );
      var previousPaymentMethod = dummyPaymentCards.firstWhere(
        (paymentCard) => paymentCard.isChosen == true,
        orElse: () => dummyPaymentCards.first,
      );
      previousPaymentMethod = previousPaymentMethod.copyWith(isChosen: false);
      chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);
      final previousIndex = dummyPaymentCards.indexWhere(
        (paymentCard) => paymentCard.id == previousPaymentMethod.id,
      );
      final chosenIndex = dummyPaymentCards.indexWhere(
        (paymentCard) => paymentCard.id == chosenPaymentMethod.id,
      );
      dummyPaymentCards[previousIndex] = previousPaymentMethod;
      dummyPaymentCards[chosenIndex] = chosenPaymentMethod;

      emit(ConfirmPaymentMethodLoded());
    });
  }
}
