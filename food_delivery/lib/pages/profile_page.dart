import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/orders_coupons_widget.dart';
import 'package:food_delivery/widgets/profile_list_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 24.0),
              CircleAvatar(
                radius:
                    size.width > 800 ? size.height * 0.2 : size.height * 0.1,
                backgroundImage: NetworkImage(
                  'https://images.inc.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg',
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Ahmed Mohamed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Software Engineer',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OrdersCouponsWidget(
                    title: 'Orders',
                    value: 10,
                  ),
                  SizedBox(
                    height: 45,
                    child: VerticalDivider(),
                  ),
                  OrdersCouponsWidget(
                    title: 'Coupons',
                    value: 5,
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              if (!Platform.isIOS) ...[
                ProfileListTile(
                  leadingIcon: Icons.shopping_cart_outlined,
                  title: 'Orders',
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                ProfileListTile(
                  leadingIcon: Icons.card_giftcard_outlined,
                  title: 'Coupons',
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
              ] else
                CupertinoListSection(
                  children: [
                    ProfileListTile(
                      leadingIcon: Icons.shopping_cart_outlined,
                      title: 'Orders',
                    ),
                    ProfileListTile(
                      leadingIcon: Icons.card_giftcard_outlined,
                      title: 'Coupons',
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
