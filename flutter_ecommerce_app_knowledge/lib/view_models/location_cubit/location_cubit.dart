import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/models/location_model.dart';
import 'package:flutter_ecommerce_app_knowledge/services/cart_services.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  final cartServices = CartServicesImpl();

  void getLocations() async {
    emit(LocationLoading());
    try {
      final locations = await cartServices.getLocations();
      emit(LocationSuccess(
        locations: locations,
      ));
    } catch (e) {
      emit(
        LocationFailed(message: e.toString()),
      );
    }
  }

  Future<void> setLocationItem(LocationModel locationModel) async {
    try {
      emit(LocationLoading());
      final selectedLocations = await cartServices.getLocations(hasQuery: true);
      if (selectedLocations.isNotEmpty) {
        await cartServices.unSetLocationItem(selectedLocations.first);
      }
      await cartServices.setLocationItem(locationModel);
      final locations = await cartServices.getLocations();
      emit(LocationSet());
      emit(LocationSuccess(locations: locations));
    } catch (e) {
      emit(
        LocationFailed(message: e.toString()),
      );
    }
  }
}
