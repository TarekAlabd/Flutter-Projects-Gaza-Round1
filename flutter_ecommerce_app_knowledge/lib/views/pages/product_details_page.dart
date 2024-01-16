import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_knowledge/models/product_item_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductDetailsPage({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(productItem.name),
    ));
  }
}
