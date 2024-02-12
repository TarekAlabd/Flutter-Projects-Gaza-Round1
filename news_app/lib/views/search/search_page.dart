import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/utils/route/app_routes.dart';
import 'package:news_app/view_models/search_cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SearchCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _searchController,
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Please enter any keyword to search for!',
                  decoration: InputDecoration(
                    hintText: 'Search',
                    contentPadding: const EdgeInsets.all(16.0),
                    suffixIcon: IconButton(
                      onPressed: () => _formKey.currentState!.validate()
                          ? cubit.search(_searchController.text)
                          : null,
                      icon: const Icon(Icons.search),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    bloc: cubit,
                    buildWhen: (previous, current) =>
                        current is SearchLoaded ||
                        current is SearchLoading ||
                        current is SearchError,
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is SearchError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is SearchLoaded) {
                        final articles = state.articles;
                        return ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (_, index) {
                            final article = articles[index];
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  article.urlToImage,
                                  width: 120,
                                  fit: BoxFit.cover,
                                  height: 120,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.error,
                                    size: 40,
                                  ),
                                ),
                              ),
                              title: Text(
                                article.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
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
                      } else {
                        return const Center(
                          child:
                              Text('Nothing yet, you can search for anything!'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
