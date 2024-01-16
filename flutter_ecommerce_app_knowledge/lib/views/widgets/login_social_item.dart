import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginSocialItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;
  const LoginSocialItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.grey3,
          ),
          // color: AppColors.grey1,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(width: 16.0),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
