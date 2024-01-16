import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_ecommerce_app_knowledge/models/product_item_model.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_routes.dart';
import 'package:flutter_ecommerce_app_knowledge/view_models/home_cubit/home_cubit.dart';
import 'package:flutter_ecommerce_app_knowledge/views/widgets/product_item.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is HomeError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is HomeLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              await BlocProvider.of<HomeCubit>(context).getHomeData();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FlutterCarousel(
                    options: CarouselOptions(
                      height: 200.0,
                      showIndicator: true,
                      slideIndicator: CircularWaveSlideIndicator(),
                    ),
                    items: state.carouselItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: CachedNetworkImage(
                            imageUrl: item.imgUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'New Arrivals',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      TextButton(
                        child: const Text('See All'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  GridView.builder(
                    itemCount: state.products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        // Un-Named Route
                        // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailsPage(productItem: state.products[index])));

                        // Named Route
                        // Navigator.of(context).pushNamed('/product-details');

                        Navigator.of(context, rootNavigator: true).pushNamed(
                          AppRoutes.productDetails,
                          arguments: state.products[index],
                        );
                      },
                      child: ProductItem(
                        productItem: state.products[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
