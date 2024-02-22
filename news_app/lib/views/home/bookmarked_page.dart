import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/utils/route/app_routes.dart';
import 'package:news_app/view_models/home_cubit/home_cubit.dart';

class BookMarkedPage extends StatelessWidget {
  const BookMarkedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: cubit,
        buildWhen: (previous, current) =>
            current is TopHeadlinesLoading ||
            current is GetArticlesLoaded ||
            current is GetArticlesError,
        builder: (context, state) {
          if (state is GetArticlesLoaded) {
            final articles = state.articles;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (_, index) {
                final article = articles[index];
                debugPrint('Article: ${article.urlToImage}');
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      article.urlToImage,
                      width: 120,
                      fit: BoxFit.cover,
                      height: 120,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.error,
                        size: 40,
                      ),
                    ),
                  ),
                  title: Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.article,
                      arguments: article,
                    );
                  },
                );
              },
            );
          } else if (state is GetArticlesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
