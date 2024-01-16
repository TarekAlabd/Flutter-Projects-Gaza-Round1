import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_routes.dart';
import 'package:flutter_ecommerce_app_knowledge/view_models/cart_cubit/cart_cubit.dart';
import 'package:flutter_ecommerce_app_knowledge/view_models/home_cubit/home_cubit.dart';
import 'package:flutter_ecommerce_app_knowledge/views/pages/cart_page.dart';
import 'package:flutter_ecommerce_app_knowledge/views/pages/favorites_page.dart';
import 'package:flutter_ecommerce_app_knowledge/views/pages/home_page.dart';
import 'package:flutter_ecommerce_app_knowledge/views/pages/profile_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late final PersistentTabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _controller.addListener(() {
      debugPrint('Controller Index: ${_controller.index}');
      setState(() {
        _currentIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return [
      BlocProvider(
        create: (context) {
          final cubit = HomeCubit();
          cubit.getHomeData();
          return cubit;
        },
        child: const HomePage(),
      ),
      BlocProvider(
        create: (context) {
          final cubit = CartCubit();
          cubit.getCartItems();
          return cubit;
        },
        child: CartPage(),
      ),
      const FavoritesPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite_border),
        title: ("Favorites"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const Padding(
          padding: EdgeInsetsDirectional.only(start: 12.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(
              'https://pbs.twimg.com/profile_images/1493704582505144323/Stvh3FSK_400x400.jpg',
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Tarek',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              'Let\'s go shopping!',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
        actions: [
          if (_currentIndex == 0) ...[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
          ],
          if (_currentIndex == 1)
            TextButton.icon(
              icon: const Icon(Icons.shopping_bag),
              label: const Text('My Orders'),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.myOrders);
              },
            ),
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
}
