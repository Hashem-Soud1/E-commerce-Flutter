// ignore_for_file: public_member_api_docs, sort_constructors_first

class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvvCode;
  final bool isChosen;

  const PaymentCardModel({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvvCode': cvvCode,
      'isChosen': isChosen,
    };
  }

  factory PaymentCardModel.fromMap(Map<String, dynamic> map) {
    return PaymentCardModel(
      id: map['id'] as String,
      cardNumber: map['cardNumber'] as String,
      cardHolderName: map['cardHolderName'] as String,
      expiryDate: map['expiryDate'] as String,
      cvvCode: map['cvvCode'] as String,
      isChosen: map['isChosen'] as bool,
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
