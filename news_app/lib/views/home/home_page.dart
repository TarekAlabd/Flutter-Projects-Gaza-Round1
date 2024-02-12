import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/utils/route/app_routes.dart';
import 'package:news_app/view_models/home_cubit/home_cubit.dart';
import 'package:news_app/views/home/widgets/app_drawer.dart';
import 'package:news_app/views/home/widgets/custom_carousel_slider.dart';
import 'package:news_app/views/home/widgets/top_headlines_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is SliderHeadlinesLoading ||
                      current is SliderHeadlinesLoaded ||
                      current is SliderHeadlinesError,
                  builder: (context, state) {
                    if (state is SliderHeadlinesLoading) {
                      return const CircularProgressIndicator.adaptive();
                    } else if (state is SliderHeadlinesLoaded) {
                      final topHeadlines = state.topHeadlines;
                      return CustomCarouselSlider(
                        articles: topHeadlines.articles,
                      );
                    } else if (state is SliderHeadlinesError) {
                      return Text(state.message);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Headlines',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.topHeadlines);
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              BlocBuilder<HomeCubit, HomeState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is TopHeadlinesLoading ||
                    current is TopHeadlinesLoaded ||
                    current is TopHeadlinesError,
                builder: (context, state) {
                  if (state is TopHeadlinesLoading) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (state is TopHeadlinesLoaded) {
                    final topHeadlineArticles =
                        state.topHeadlinesApiResponse.articles;
                    return SizedBox(
                      height: size.height * 0.4,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: topHeadlineArticles.length,
                        itemBuilder: (context, index) {
                          final article = topHeadlineArticles[index];
                          return Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 16.0),
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.article,
                                      arguments: article);
                                },
                                child: TopHeadlinesItem(article: article)),
                          );
                        },
                      ),
                    );
                  } else if (state is TopHeadlinesError) {
                    return Text(state.message);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
