import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_colors.dart';
import 'package:flutter_ecommerce_app_knowledge/view_models/location_cubit/location_cubit.dart';

class LocationItemWidget extends StatefulWidget {
  final int index;
  const LocationItemWidget({super.key, required this.index});

  @override
  State<LocationItemWidget> createState() => _LocationItemWidgetState();
}

class _LocationItemWidgetState extends State<LocationItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LocationCubit>(context);
    return BlocBuilder<LocationCubit, LocationState>(
      bloc: cubit,
      buildWhen: (previous, current) => current is LocationSuccess,
      builder: (context, state) {
        if (state is LocationSuccess) {
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: 12.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: state.locations[widget.index].isSelected
                        ? AppColors.primary
                        : AppColors.grey),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.locations[widget.index].cityName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${state.locations[widget.index].cityName}, ${state.locations[widget.index].countryName}',
                          style: const TextStyle(color: AppColors.grey),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: state.locations[widget.index].isSelected
                          ? AppColors.primary
                          : AppColors.grey,
                      radius: 38,
                      child: CachedNetworkImage(
                        imageUrl: state.locations[widget.index].imgUrl,
                        height: 70,
                      ),
                    ),
                  ],
                ),
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
