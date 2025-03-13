import 'package:ecommerce_app/models/add_new_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_card_state.dart';

class AddNewCardCubit extends Cubit<AddNewCardState> {
  AddNewCardCubit() : super(AddNewCardInitial());

  void addNewCard(PaymentCardModel addNewCardModel) {
    emit(AddNewCardLoading());

    Future.delayed(Duration(seconds: 1), () {
      dummyPaymentCards.add(addNewCardModel);
      emit(AddNewCardLoded(addNewCardModel: addNewCardModel));
    });
  }

  void getPaymentCards() {
    emit(PaymentCardLoading());

    Future.delayed(Duration(seconds: 1), () {
      emit(PyamentCardLoded(paymentCards: dummyPaymentCards));
    });
  }
}
