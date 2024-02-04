import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce_app_knowledge/models/location_model.dart';
import 'package:flutter_ecommerce_app_knowledge/models/product_item_model.dart';
import 'package:flutter_ecommerce_app_knowledge/services/cart_services.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  final cartServices = CartServicesImpl();

  Future<void> getPaymentViewData() async {
    emit(PaymentLoading());
    try {
      final cartItems = await cartServices.getCartItems();
      final subTotal = cartItems.fold<double>(
          0, (sum, item) => sum + (item.product.price * item.quantity));
  final selectedLocation = (await cartServices.getLocations(hasQuery: true)).isNotEmpty ? (await cartServices.getLocations(hasQuery: true)).first : null;
      emit(PaymentLoaded(
        cartItems: cartItems,
        total: subTotal + 10,
        location: selectedLocation,
      ));
    } catch (e) {
      emit(
        PaymentError(message: e.toString()),
      );
    }
  }

  void choosePaymentMethod(String paymentMethodId) {
    emit(PaymentMethodChosen(paymentMethodId: paymentMethodId));
  }
}
