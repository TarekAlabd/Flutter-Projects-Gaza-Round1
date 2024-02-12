import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/top_headlines_request.dart';
import 'package:news_app/services/home_services.dart';
import 'package:news_app/utils/app_constants.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final homeServices = HomeServicesImpl();

  Future<void> search(String query) async {
    emit(SearchLoading());
    try {
      final response = await homeServices.getTopHeadlines(TopHeadlinesRequest(country: 'us', q: query), 'Bearer ${AppConstants.token}');
      emit(SearchLoaded(response.articles));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
