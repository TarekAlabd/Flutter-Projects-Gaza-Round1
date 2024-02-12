import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/article.dart';

class TopHeadlinesItem extends StatelessWidget {
  final Article article;
  const TopHeadlinesItem({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat.yMMMd().add_jm();
    DateTime parsedDate = DateTime.parse(article.publishedAt);
    String publishedAt = format.format(parsedDate);
    return SizedBox(
      height: 490,
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              article.urlToImage,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : const CircularProgressIndicator.adaptive(),
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
              height: 200,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  publishedAt,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.author,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
