import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_colors.dart';

class ClickableBoxWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? imgUrl;
  final VoidCallback? onTap;
  const ClickableBoxWidget({super.key, required this.title, this.onTap, this.imgUrl, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity, 
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: size.width/1.102,
          height: 120,
          decoration: BoxDecoration(
            color: imgUrl != null? Colors.white10 : AppColors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: imgUrl != null ?
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: imgUrl!
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                    if(subTitle != null)
                      Text(
                        subTitle!,
                        style: const TextStyle(
                          color: AppColors.grey
                        ),
                      )
                  ],
                ),
              ],
            ):
            Center(child: Text(title),)
        ),
      ),
    );
  }
}