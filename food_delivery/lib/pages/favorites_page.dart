import 'package:flutter/material.dart';
import 'package:food_delivery/models/food_item.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key}) {
    debugPrint('FavoritesPage constructor');
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    debugPrint('FavoritesPage build()');

    return ListView.builder(
        itemCount: food.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/product-Details',
                    arguments: food[index],
                  );
                },
                leading: Image.network(
                  food[index].imgUrl,
                  height: 100,
                  width: 70,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  food[index].name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${food[index].category} - \$${food[index].price}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                trailing: orientation == Orientation.portrait
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite),
                        color: Colors.deepOrange,
                      )
                    : TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline_rounded),
                        label: Text('Favorite'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.deepOrange,
                        )),
              ),
            ),
          );
        });
  }
}
