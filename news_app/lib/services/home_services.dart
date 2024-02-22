import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/top_headlines_api_response.dart';
import 'package:news_app/models/top_headlines_request.dart';
import 'package:news_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeServices {
  Future<TopHeadlinesApiResponse> getUsTopHeadlines();
  Future<TopHeadlinesApiResponse> getTopHeadlines(
      TopHeadlinesRequest requestBody, String authToken);
  Future<void> saveArticle(Article article);
  Future<void> deleteArticle(Article article);
  Future<List<Article>> getArticles();
  Future<bool> isBookmarked(Article article);
}

class HomeServicesImpl implements HomeServices {
  final dio = Dio();

  @override
  Future<TopHeadlinesApiResponse> getUsTopHeadlines() async {
    dio.options.baseUrl = AppConstants.baseUrl;
    debugPrint('request base url: ${dio.options.baseUrl}');
    Response<Map<String, dynamic>> response = await dio.get(
      AppConstants.topHeadlines,
      queryParameters: {
        'country': 'us',
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer 483cfdf815b34dd48e59c99e7767167f',
        },
      ),
    );
    debugPrint('response: ${response.data}');
    if (response.statusCode != 200) {
      throw Exception('Failed to load top headlines');
    }

    return TopHeadlinesApiResponse.fromJson(response.data!);
  }

  @override
  Future<TopHeadlinesApiResponse> getTopHeadlines(
      TopHeadlinesRequest requestBody, String authToken) async {
    dio.options.baseUrl = AppConstants.baseUrl;
    final headers = {
      'Authorization': authToken,
    };
    Response<Map<String, dynamic>> response = await dio.get(
      AppConstants.topHeadlines,
      queryParameters: requestBody.toMap(),
      options: Options(
        headers: headers,
      ),
    );
    debugPrint('response: ${response.data}');
    if (response.statusCode != 200) {
      throw Exception('Failed to load top headlines');
    }

    return TopHeadlinesApiResponse.fromJson(response.data!);
  }

  @override
  Future<void> deleteArticle(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final articles = prefs.getStringList(AppConstants.articlesCache);
    if (articles != null) {
      final updatedArticles = articles
          .where((currentArticle) => currentArticle != article.toJson())
          .toList();
      final result = await prefs.setStringList(
          AppConstants.articlesCache, updatedArticles);
      if (!result) {
        throw Exception('Failed to delete article');
      }
    } else {
      throw Exception('There is no bookmarked items!');
    }
  }

  @override
  Future<List<Article>> getArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final articles = prefs.getStringList(AppConstants.articlesCache) ?? [];
    debugPrint(articles.toString());
    return articles.map((article) => Article.fromJson(article)).toList();
  }

  @override
  Future<void> saveArticle(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final articles = prefs.getStringList(AppConstants.articlesCache) ?? [];
    articles.add(article.toJson());
    final result =
        await prefs.setStringList(AppConstants.articlesCache, articles);
    if (!result) {
      throw Exception('Failed to save article');
    }
  }

  @override
  Future<bool> isBookmarked(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final articles = prefs.getStringList(AppConstants.articlesCache) ?? [];
    return articles.any((currentArticle) => currentArticle == article.toJson());
  }
}





















// final Dio _dio;

//   HomeServicesImpl(this._dio);

//   @override
//   Future<TopHeadlinesApiResponse> getTopHeadlines() async {
//     try {
//       final response = await _dio.get(
//         'top-headlines',
//         queryParameters: {
//           'country': 'us',
//           'apiKey': 'YOUR_API_KEY',
//         },
//       );
//       return TopHeadlinesApiResponse.fromJson(response.data);
//     } on DioError catch (e) {
//       throw e.error;
//     }
//   }