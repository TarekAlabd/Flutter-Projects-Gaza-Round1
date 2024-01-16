import 'package:flutter/material.dart';

class OrdersCouponsWidget extends StatelessWidget {
  final String title;
  final int value;
  const OrdersCouponsWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
