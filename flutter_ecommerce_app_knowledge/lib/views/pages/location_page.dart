import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/models/location_model.dart';
import 'package:flutter_ecommerce_app_knowledge/view_models/location_cubit/location_cubit.dart';
import 'package:flutter_ecommerce_app_knowledge/views/widgets/location_item_widget.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LocationCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose your location',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'let\'s find your unforgettable event. Choose a location below to get started',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.black),
                    ),
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'San Diego, CA',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.gps_fixed_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Select location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              BlocConsumer<LocationCubit, LocationState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is LocationSuccess ||
                    current is LocationLoading ||
                    current is LocationFailed,
                listenWhen: (previous, current) => current is LocationSet,
                listener: (context, state) {
                  if (state is LocationSet) {
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  if (state is LocationLoading) {
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 170.0, vertical: 18),
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is LocationSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.locations.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: LocationItemWidget(index: index),
                          onTap: () {
                              cubit.setLocationItem(state.locations[index]);
                          },
                        );
                      },
                    );
                  } else if (state is LocationFailed) {
                    return Text(state.message);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
