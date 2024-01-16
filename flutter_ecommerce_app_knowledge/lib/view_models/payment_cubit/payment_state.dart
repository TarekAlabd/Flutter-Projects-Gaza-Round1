part of 'payment_cubit.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentLoaded extends PaymentState {
  // final List<PaymentMethodModel> paymentMethods;
  List<ProductItemModel> cartItems;
  final double total;

  PaymentLoaded({
    // required this.paymentMethods,
    required this.cartItems,
    required this.total,
  });
}

final class PaymentError extends PaymentState {
  final String message;

  PaymentError({
    required this.message,
  });
}

final class PaymentMethodChosen extends PaymentState {
  final String paymentMethodId;

  PaymentMethodChosen({
    required this.paymentMethodId,
  });
}