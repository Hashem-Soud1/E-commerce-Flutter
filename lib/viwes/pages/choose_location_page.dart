import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:ecommerce_app/view_model/location_page_cubit/location_page_cubit.dart';
import 'package:ecommerce_app/viwes/widgets/location_item.dart';
import 'package:ecommerce_app/viwes/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key});

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChooseLocationCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Address')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your location',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Text(
                  'Let\'s find an unforgettable event. Choose a location below to get started:',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
                ),
                const SizedBox(height: 36),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on),
                    suffixIcon:
                        BlocConsumer<ChooseLocationCubit, ChooseLocationState>(
                          bloc: cubit,
                          buildWhen:
                              (previous, current) =>
                                  current is AddingLocation ||
                                  current is LocationAdded ||
                                  current is LocationAddingFailure,
                          listenWhen:
                              (previous, current) =>
                                  current is LocationAdded ||
                                  current is ShippingMethodLoaded,
                          listener: (context, state) {
                            if (state is LocationAdded) {
                              locationController.clear();
                            }

                            if (state is ShippingMethodLoaded) {
                              Navigator.of(context).pop();
                            }
                          },
                          builder: (context, state) {
                            if (state is AddingLocation) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: AppColors.grey,
                                ),
                              );
                            }
                            return IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                if (locationController.text.isNotEmpty) {
                                  cubit.addLocation(locationController.text);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Enter your location!'),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                    suffixIconColor: AppColors.grey,
                    prefixIconColor: AppColors.grey,
                    hintText: 'Write location: city-country',
                    fillColor: AppColors.grey1,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Text(
                  'Select Location',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                  bloc: cubit,
                  buildWhen:
                      (previous, current) =>
                          current is FetchLocationsFailure ||
                          current is FetchedLocations ||
                          current is FetchingLocations,
                  builder: (context, state) {
                    if (state is FetchingLocations) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is FetchedLocations) {
                      final locations = state.locations;

                      return ListView.builder(
                        itemCount: locations.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final location = locations[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocBuilder<
                              ChooseLocationCubit,
                              ChooseLocationState
                            >(
                              bloc: cubit,
                              buildWhen:
                                  (previous, current) =>
                                      current is LocalSelectedLocation,
                              builder: (context, state) {
                                if (state is LocalSelectedLocation) {
                                  final ChosenLocation = state.location;

                                  return LocationItem(
                                    location: location,
                                    onTap: () {
                                      cubit.selectLocation(location.id);
                                    },
                                    borderColor:
                                        ChosenLocation.id == location.id
                                            ? AppColors.primary
                                            : AppColors.grey,
                                  );
                                }
                                return LocationItem(
                                  location: location,
                                  onTap: () {
                                    cubit.selectLocation(location.id);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is FetchLocationsFailure) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                const SizedBox(height: 24),
                BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                  bloc: cubit,
                  buildWhen:
                      (previous, current) =>
                          current is ShippingMethodLoaded ||
                          current is ShippingMethodError ||
                          current is ShippingMethodLoading,

                  builder: (context, state) {
                    if (state is ShippingMethodLoading) {
                      return MainButton(isLoading: true);
                    } else if (state is ShippingMethodError) {
                      return Center(child: Text(state.message));
                    }
                    return MainButton(
                      text: 'Confirm Address',
                      onTap: () {
                        cubit.confirmLocation();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
