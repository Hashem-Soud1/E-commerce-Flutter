class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvvCode;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvvCode,
  });
}

List<PaymentCardModel> dummyPaymentCards = [
  PaymentCardModel(
    id: '1',
    cardNumber: '**** **** **** 1234',
    cardHolderName: 'Hashem Soud',
    expiryDate: '1/24',
    cvvCode: '123',
  ),
  PaymentCardModel(
    id: '2',
    cardNumber: '**** **** **** 5678',
    cardHolderName: 'Bara Ahmed',
    expiryDate: '12/24',
    cvvCode: '123',
  ),
  PaymentCardModel(
    id: '3',
    cardNumber: '**** **** **** 9101',
    cardHolderName: 'Ali Doe',
    expiryDate: '9/24',
    cvvCode: '123',
  ),
];
