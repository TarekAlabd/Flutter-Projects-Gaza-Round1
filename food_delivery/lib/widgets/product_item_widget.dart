import 'package:flutter/material.dart';
import 'package:food_delivery/models/food_item.dart';

class ProductItemWidget extends StatefulWidget {
  final BoxConstraints constraints;
  final int index;
  final List<FoodItem> filteredFood;

  const ProductItemWidget({
    super.key,
    required this.constraints,
    required this.index,
    required this.filteredFood,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final filteredFood = widget.filteredFood;
    final index = widget.index;
    final constraints = widget.constraints;
    debugPrint('ProductItemWidget build()');
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              children: [
                Image.network(
                  filteredFood[index].imgUrl,
                  height: constraints.maxHeight * 0.5,
                ),
                Text(
                  filteredFood[index].name,
                  style: TextStyle(
                    fontSize: constraints.maxHeight * 0.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filteredFood[index].category,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '\$ ${filteredFood[index].price}',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: constraints.maxHeight * 0.09,
                  ),
                ),
              ],
            ),
            PositionedDirectional(
              top: 0,
              end: 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    filteredFood[index] = filteredFood[index]
                        .copyWith(isFavorite: !filteredFood[index].isFavorite);
                    final selectedFoodItem = food.firstWhere(
                        (item) => item.id == filteredFood[index].id);
                    final selectedFoodItemIndex =
                        food.indexOf(selectedFoodItem);
                    food[selectedFoodItemIndex] = filteredFood[index];
                  });
                },
                icon: Icon(
                  filteredFood[index].isFavorite == false
                      ? Icons.favorite_border
                      : Icons.favorite,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
