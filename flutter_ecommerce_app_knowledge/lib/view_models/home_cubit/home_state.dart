part of 'home_cubit.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductItemModel> products;
  final List<HomeCarouselModel> carouselItems;

  const HomeLoaded({
    required this.products,
    required this.carouselItems,
  });
}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});
}
