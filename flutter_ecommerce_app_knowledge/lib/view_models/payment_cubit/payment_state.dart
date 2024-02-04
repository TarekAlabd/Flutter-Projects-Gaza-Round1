part of 'payment_cubit.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentLoaded extends PaymentState {
  // final List<PaymentMethodModel> paymentMethods;
  List<AddToCartModel> cartItems;
  final double total;
  final LocationModel? location;

  PaymentLoaded({
    // required this.paymentMethods,
    required this.cartItems,
    required this.total,
    this.location,
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