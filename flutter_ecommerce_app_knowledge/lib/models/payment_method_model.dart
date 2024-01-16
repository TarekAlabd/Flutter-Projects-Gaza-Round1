class PaymentMethodModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvvCode;
  final String imgUrl;
  final String name;

  PaymentMethodModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvvCode,
    this.name = 'Master Card',
    this.imgUrl =
        'https://images.fastcompany.net/image/upload/w_1200,c_limit,q_auto:best/wp-cms/uploads/2023/04/i-3-90885664-mastercard-logo.jpg',
  });
}

List<PaymentMethodModel> savedCards = [
  PaymentMethodModel(
    id: '1',
    cardNumber: '4568987543278432',
    cardHolderName: 'Ahmed Mohamed',
    expiryDate: '01/28',
    cvvCode: '375',
  ),
  PaymentMethodModel(
    id: '2',
    cardNumber: '4568967543273432',
    cardHolderName: 'Tala Mohamed',
    expiryDate: '01/25',
    cvvCode: '388',
  ),
  PaymentMethodModel(
    id: '3',
    cardNumber: '4568887543274432',
    cardHolderName: 'Samy Mohamed',
    expiryDate: '01/26',
    cvvCode: '283',
  ),
];
