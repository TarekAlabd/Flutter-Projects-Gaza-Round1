import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_colors.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_routes.dart';
import 'package:flutter_ecommerce_app_knowledge/view_models/payment_cubit/payment_cubit.dart';
import 'package:flutter_ecommerce_app_knowledge/views/widgets/clickable_box_widget.dart';
import 'package:flutter_ecommerce_app_knowledge/views/widgets/payment_modal_bottom_sheet.dart';
import 'package:flutter_ecommerce_app_knowledge/views/widgets/product_item_payment_widget.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        bloc: cubit,
        buildWhen: (previous, current) =>
            current is PaymentLoaded ||
            current is PaymentLoading ||
            current is PaymentError,
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is PaymentLoaded) {
            final location = state.location;
            final cartItems = state.cartItems;
            final total = state.total;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    buildInlineHeadlines(
                      context: context,
                      title: 'Address',
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.locationPage);
                        // if (!mounted) return;
                        // setState(() {});
                      },
                    ),
                    const SizedBox(height: 8.0),
                    if (location != null)
                      ClickableBoxWidget(
                        title: location.cityName,
                        imgUrl: location.imgUrl,
                        subTitle:
                            '${location.cityName}, ${location.countryName}',
                        onTap: () async {
                          await Navigator.of(context, rootNavigator: true)
                              .pushNamed(AppRoutes.locationPage);
                          await cubit.getPaymentViewData();
                          // if (!mounted) return;
                          // setState(() {});
                        },
                      ),
                    if (location == null)
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.locationPage);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: Text('Add Address'),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16.0),
                    buildInlineHeadlines(
                      context: context,
                      title: 'Products',
                      productsNumbers: state.cartItems.length,
                    ),
                    const SizedBox(height: 8.0),
                    ListView.builder(
                      itemCount: state.cartItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];

                        return ProductItemPaymentWidget(item: item);
                      },
                    ),
                    buildInlineHeadlines(
                      context: context,
                      title: 'Payment Method',
                    ),
                    const SizedBox(height: 8.0),
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) => BlocProvider.value(
                          value: BlocProvider.of<PaymentCubit>(context),
                          child: const PaymentModalBottomSheet(),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text('Add Payment Method'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: AppColors.grey,
                                  ),
                        ),
                        Text(
                          '\$$total',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 34.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: AppColors.white,
                          ),
                          child: const Text('Checkout Now'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 34.0),
                  ],
                ),
              ),
            );
          } else if (state is PaymentError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }

  Widget buildInlineHeadlines({
    required BuildContext context,
    required String title,
    int? productsNumbers,
    VoidCallback? onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (productsNumbers != null)
              Text(
                '($productsNumbers)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
          ],
        ),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              'Edit',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
      ],
    );
  }
}
