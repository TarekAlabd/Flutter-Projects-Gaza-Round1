import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/article.dart';
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
      final articles = response.articles;
      emit(GetArticlesLoaded(articles));
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

  Future<void> saveArticle(Article article) async {
    try {
      await homeServices.saveArticle(article);
      emit(ArticleSaved());
    } catch (e) {
      emit(SaveArticleError(e.toString()));
    }
  }

  Future<void> deleteArticle(Article article) async {
    try {
      await homeServices.deleteArticle(article);
      emit(ArticleDeleted());
    } catch (e) {
      emit(DeleteArticleError(e.toString()));
    }
  }

  Future<void> getBookmarkedArticles() async {
    emit(TopHeadlinesLoading());
    try {
      final articles = await homeServices.getArticles();
      emit(GetArticlesLoaded(articles));
    } catch (e) {
      emit(GetArticlesError(e.toString()));
    }
  }
}
