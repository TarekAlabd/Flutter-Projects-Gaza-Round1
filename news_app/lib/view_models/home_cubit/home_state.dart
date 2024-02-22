part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class TopHeadlinesLoading extends HomeState {}

final class TopHeadlinesError extends HomeState {
  final String message;

  TopHeadlinesError(this.message);
}

final class SliderHeadlinesLoading extends HomeState {}

final class SliderHeadlinesLoaded extends HomeState {
  final TopHeadlinesApiResponse topHeadlines;

  SliderHeadlinesLoaded(this.topHeadlines);
}

final class SliderHeadlinesError extends HomeState {
  final String message;

  SliderHeadlinesError(this.message);
}

final class SaveArticleError extends HomeState {
  final String message;

  SaveArticleError(this.message);
}

final class DeleteArticleError extends HomeState {
  final String message;

  DeleteArticleError(this.message);
}

final class GetArticlesError extends HomeState {
  final String message;

  GetArticlesError(this.message);
}

final class GetArticlesLoaded extends HomeState {
  final List<Article> articles;

  GetArticlesLoaded(this.articles);
}

final class ArticleSaved extends HomeState {}

final class ArticleDeleted extends HomeState {}
