import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/models/home_carousel_model.dart';
import 'package:flutter_ecommerce_app_knowledge/models/product_item_model.dart';
import 'package:flutter_ecommerce_app_knowledge/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImpl();

  Future<void> addProduct(ProductItemModel product) async {
    await homeServices.addProduct(product);
  }

  Future<void> deleteProduct(String id) async {
    await homeServices.deleteProduct(id);
  }

  Future<void> getHomeData() async {
    emit(HomeLoading());
    // final products = homeServices.getProductsStream();
    // products.listen((event) {
    //   emit(
    //     HomeLoaded(
    //       products: event,
    //       carouselItems: dummyCarouselItems,
    //     ),
    //   );
    // });
    final products = await homeServices.getProducts();
    emit(
        HomeLoaded(
          products: products,
          carouselItems: dummyCarouselItems,
        ),
      );
  }
}
