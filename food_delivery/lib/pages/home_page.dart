import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/category_item.dart';
import 'package:food_delivery/models/food_item.dart';
import 'package:food_delivery/pages/product_details_page.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/widgets/product_item_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key}) {
    debugPrint('HomePage constructor');
  }

  @override
  State<HomePage> createState() {
    debugPrint('HomePage createState()');
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  _HomePageState() {
    debugPrint('HomePageState constructor');
  }

  int? selectedCategoryIndex;
  late List<FoodItem> filteredFood;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    debugPrint('HomePage initState()');
    WidgetsBinding.instance.addObserver(this);
    if (isLoading) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
    }
    filteredFood = food;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('HomePage didChangeDependencies()');
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('HomePage didUpdateWidget()');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint('HomePage didChangeAppLifecycleState()');
    if (state == AppLifecycleState.inactive) {
      debugPrint('AppLifecycleState.inactive');
    } else if (state == AppLifecycleState.paused) {
      debugPrint('AppLifecycleState.paused');
    } else if (state == AppLifecycleState.resumed) {
      debugPrint('AppLifecycleState.resumed');
    } else if (state == AppLifecycleState.detached) {
      debugPrint('AppLifecycleState.detached');
    } else {
      debugPrint('AppLifecycleState.unknown');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    debugPrint('HomePage build()');

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.menu),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Current Location',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.green,
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            'Cairo, Egypt',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.notifications),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  'https://marketplace.canva.com/EAFVfgsKMAE/1/0/1600w/canva-black-and-yellow-simple-minimalist-burger-promotion-banner-YTqWS2eL8TM.jpg',
                  height:
                      size.width > 800 ? size.height * 0.45 : size.height * 0.2,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                  ),
                  hintText: 'Find your food...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                height: orientation == Orientation.landscape
                    ? size.height * 0.3
                    : size.height * 0.15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(end: 12.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedCategoryIndex == null ||
                              selectedCategoryIndex != index) {
                            selectedCategoryIndex = index;
                          } else {
                            selectedCategoryIndex = null;
                            filteredFood = food;
                          }
                        });
                        if (selectedCategoryIndex != null) {
                          final selectedCategory =
                              categories[selectedCategoryIndex!];
                          filteredFood = food
                              .where((foodItem) =>
                                  foodItem.category == selectedCategory.name)
                              .toList();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: index == selectedCategoryIndex
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                categories[index].assetPath,
                                height: 50,
                                width: 50,
                                color: index == selectedCategoryIndex
                                    ? AppColors.white
                                    : null,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                categories[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: index == selectedCategoryIndex
                                      ? AppColors.white
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 1100
                      ? 5
                      : size.width > 800
                          ? 4
                          : 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredFood.length,
                itemBuilder: (_, index) =>
                    LayoutBuilder(builder: (context, constraints) {
                  debugPrint('constraints.maxHeight: ${constraints.maxHeight}');
                  return InkWell(
                    onTap: () async {
                      // Navigator.of(context).pushNamed('/product-Details');
                      final backValue = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            foodItem: filteredFood[index],
                          ),
                        ),
                      );
                      debugPrint(backValue.toString());
                    },
                    child: ProductItemWidget(
                      constraints: constraints,
                      index: index,
                      filteredFood: filteredFood,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
