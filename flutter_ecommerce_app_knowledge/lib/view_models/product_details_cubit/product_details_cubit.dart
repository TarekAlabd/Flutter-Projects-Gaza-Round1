import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce_app_knowledge/models/product_item_model.dart';
import 'package:flutter_ecommerce_app_knowledge/services/product_details_services.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductSize? selectedSize;
  int quantity = 1;
  final productDetailsServices = ProductDetailsServicesImpl();

  Future<void> getProductDetails(String id) async {
    emit(ProductDetailsLoading());
    final selectedProduct = await productDetailsServices.getProductDetails(id);
    emit(ProductDetailsLoaded(product: selectedProduct));
  }

  void selectSize(ProductSize size) {
    selectedSize = size;
    emit(SizeSelected(size: size));
  }

  Future<void> addToCart(String productId) async {
    emit(ProductAddingToCart());
    try {
      final selectedProduct = await productDetailsServices.getProductDetails(productId);
    final cartItem = AddToCartModel(
      id: DateTime.now().toIso8601String(),
      product: selectedProduct,
      size: selectedSize!,
      quantity: quantity,
    );
    await productDetailsServices.addToCart(cartItem);
    emit(
          ProductAddedToCart(productId: productId),
        );
    } catch (e) {
      emit(
        ProductDetailsError(message: e.toString()),
      );
    }
  }

  void increment(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrement(String productId) {
    quantity--;
    emit(QuantityCounterLoaded(value: quantity));
  }
}
