import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce_app_knowledge/models/product_item_model.dart';
import 'package:flutter_ecommerce_app_knowledge/services/cart_services.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final cartServices = CartServicesImpl();

  Future<void> getCartItems() async {
    emit(CartLoading());
    try {
      final cartItems = await cartServices.getCartItems();
    final subTotal = cartItems.fold<double>(0, (sum, item) => sum + (item.product.price * item.quantity));
    emit(CartLoaded(
        cartItems: cartItems,
        subtotal: subTotal,
      ));
    } catch (e) {
      emit(
        CartError(message: e.toString()),
      );
    }
  }

  // void removeFromCart(String productId) {
  //   emit(CartLoading());
  //   final index = dummyProducts.indexWhere((item) => item.id == productId);
  //   dummyProducts[index] = dummyProducts[index].copyWith(
  //     isAddedToCart: false,
  //     quantity: 0,
  //     size: null,
  //   );
  //   final cartItems =
  //       dummyProducts.where((item) => item.isAddedToCart == true).toList();
  //   final subTotal = cartItems.fold<double>(0, (sum, item) => sum + item.price);
  //   Future.delayed(const Duration(seconds: 1), () {
  //     emit(CartLoaded(
  //       cartItems: cartItems,
  //       subtotal: subTotal,
  //     ));
  //   });
  // }

  void increment(String productId) {
    final index = dummyProducts.indexWhere((item) => item.id == productId);
    dummyProducts[index] = dummyProducts[index].copyWith(
      quantity: dummyProducts[index].quantity + 1,
    );
    emit(
      QuantityCounterLoaded(
        value: dummyProducts[index].quantity,
        productId: productId,
      ),
    );
    // emit(CartLoaded(
    //     cartItems: dummyProducts
    //         .where((item) => item.isAddedToCart == true)
    //         .toList()));
  }

  void decrement(String productId) {
    final index = dummyProducts.indexWhere((item) => item.id == productId);
    dummyProducts[index] = dummyProducts[index].copyWith(
      quantity: dummyProducts[index].quantity - 1,
    );
    emit(QuantityCounterLoaded(
      value: dummyProducts[index].quantity,
      productId: productId,
    ));
    // emit(CartLoaded(
    //     cartItems: dummyProducts
    //         .where((item) => item.isAddedToCart == true)
    //         .toList()));
  }
}
