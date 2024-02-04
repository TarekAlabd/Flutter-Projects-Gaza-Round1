import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_knowledge/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_colors.dart';

class ProductItemPaymentWidget extends StatelessWidget {
  final AddToCartModel item;
  const ProductItemPaymentWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: AppColors.grey.withOpacity(0.4),
            ),
            child: CachedNetworkImage(
              imageUrl: item.product.imgUrl,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (item.size == null)
                      Text(
                        'No Size',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.grey,
                                ),
                      ),
                    if (item.size != null)
                      Text.rich(
                        TextSpan(
                          text: 'Size: ',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppColors.grey,
                                  ),
                          children: [
                            TextSpan(
                              text: item.size!.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    Text(
                      '\$${item.totalPrice}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
