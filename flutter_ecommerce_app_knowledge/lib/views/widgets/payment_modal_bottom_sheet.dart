import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_knowledge/models/payment_method_model.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_colors.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_routes.dart';
import 'package:flutter_ecommerce_app_knowledge/views/widgets/payment_item_widget.dart';

class PaymentModalBottomSheet extends StatelessWidget {
  const PaymentModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24.0),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: savedCards.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return PaymentItemWidget(
                  paymentMethod: savedCards[index],
                );
              },
            ),
            PaymentItemWidget(
              additionOnTap: () {
                Navigator.of(context).pushNamed(AppRoutes.addPaymentCard);
              },
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: AppColors.white,
                ),
                child: const Text('Confirm Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
