part of 'location_cubit.dart';

sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {
  final List<LocationModel> locations;

  LocationSuccess({
    required this.locations,
  });
}

final class LocationSet extends LocationState {

  LocationSet();
}

final class LocationFailed extends LocationState {
  final String message;

  LocationFailed({required this.message});
}

final class PaymentMethodChosen extends LocationState {
  final String paymentMethodId;

  PaymentMethodChosen({required this.paymentMethodId});
}
