import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/top_headlines_api_response.dart';
import 'package:news_app/models/top_headlines_request.dart';
import 'package:news_app/services/home_services.dart';
import 'package:news_app/utils/app_constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServicesImpl();

  Future<void> getTopUsHeadlines() async {
    emit(TopHeadlinesLoading());
    try {
      final response = await homeServices.getUsTopHeadlines();
      emit(TopHeadlinesLoaded(response));
    } catch (e) {
      emit(TopHeadlinesError(e.toString()));
    }
  }

  Future<void> getTopHeadlines(TopHeadlinesRequest requestBody) async {
    emit(SliderHeadlinesLoading());
    try {
      final response = await homeServices.getTopHeadlines(
        requestBody,
        'Bearer ${AppConstants.token}',
      );
      emit(SliderHeadlinesLoaded(response));
    } catch (e) {
      emit(SliderHeadlinesError(e.toString()));
    }
  }
}
