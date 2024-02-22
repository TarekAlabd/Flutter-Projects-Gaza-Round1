import 'package:news_app/models/article.dart';

class TopHeadlinesApiResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  TopHeadlinesApiResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory TopHeadlinesApiResponse.fromJson(Map<String, dynamic> json) {
    return TopHeadlinesApiResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: List<Article>.from(
        json['articles'].map(
          (x) => Article.fromMap(x),
        ),
      ),
    );
  }
}
