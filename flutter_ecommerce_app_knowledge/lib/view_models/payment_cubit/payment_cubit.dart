import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/models/product_item_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  void getPaymentViewData() {
    emit(PaymentLoading());
    final cartItems =
        dummyProducts.where((item) => item.isAddedToCart == true).toList();
    final subTotal = cartItems.fold<double>(0, (sum, item) => sum + item.price);
    Future.delayed(const Duration(seconds: 1), () {
      emit(PaymentLoaded(
        cartItems: cartItems,
        total: subTotal + 10,
      ));
    });
  }

  void choosePaymentMethod(String paymentMethodId) {
    emit(PaymentMethodChosen(paymentMethodId: paymentMethodId));
  }
}
