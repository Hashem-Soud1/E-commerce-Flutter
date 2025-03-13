class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvvCode;
  final bool isChosen;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvvCode,
    this.isChosen = false,
  });

  PaymentCardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvvCode,
    bool? isChosen,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvvCode: cvvCode ?? this.cvvCode,
      isChosen: isChosen ?? this.isChosen,
    );
  }
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
    cvvCode: '456',
  ),
  PaymentCardModel(
    id: '3',
    cardNumber: '**** **** **** 9101',
    cardHolderName: 'Ali Doe',
    expiryDate: '9/24',
    cvvCode: '789',
  ),
];
