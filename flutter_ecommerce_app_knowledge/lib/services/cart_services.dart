import 'package:flutter_ecommerce_app_knowledge/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce_app_knowledge/models/location_model.dart';
import 'package:flutter_ecommerce_app_knowledge/services/auth_services.dart';
import 'package:flutter_ecommerce_app_knowledge/services/firestore_services.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/api_path.dart';

abstract class CartServices {
  Future<List<AddToCartModel>> getCartItems();
  Future<List<LocationModel>> getLocations();
  Future<void> setLocationItem(LocationModel locationModel);
  Future<void> unSetLocationItem(LocationModel locationModel);
  // Future<List<LocationModel>> getPayments();
}

class CartServicesImpl implements CartServices {
  final firestore = FirestoreService.instance;
  final authServices = AuthServicesImpl();

  @override
  Future<List<AddToCartModel>> getCartItems() async {
    final currentUser = await authServices.getUser();
    return await firestore.getCollection(
      path: ApiPath.getCartItems(currentUser!.uid),
      builder: (data, documentId) => AddToCartModel.fromMap(data, documentId),
    );
  }
  
  @override
  Future<List<LocationModel>> getLocations({bool hasQuery = false}) async {
    final currentUser = await authServices.getUser();
    return await firestore.getCollection(
      path: ApiPath.locations(currentUser!.uid),
      builder: (data, documentId) => LocationModel.fromMap(data, documentId),
      queryBuilder: hasQuery ? (query) => query.where('isSelected', isEqualTo: true) : null,
    );
  }
  
  @override
  Future<void> setLocationItem(LocationModel locationModel) async {
    final currentUser = await authServices.getUser();
    await firestore.setData(
        path: ApiPath.location(currentUser!.uid, locationModel.id),
        data: locationModel.copyWith(isSelected: true).toMap(),
      );
  }
  
  @override
  Future<void> unSetLocationItem(LocationModel locationModel) async {
    final currentUser = await authServices.getUser();
    await firestore.setData(
        path: ApiPath.location(currentUser!.uid, locationModel.id),
        data: locationModel.copyWith(isSelected: false).toMap(),
      );
  }
}
