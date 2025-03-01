import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/view_model/home_state/cubit/home_cubit.dart';
import 'package:ecommerce_app/viwes/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),

      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlutterCarousel.builder(
                    itemCount: state.carouselItems.length,
                    itemBuilder:
                        (
                          BuildContext context,
                          int itemIndex,
                          int pageViewIndex,
                        ) => Padding(
                          padding: const EdgeInsetsDirectional.only(end: 16.0),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: CachedNetworkImage(
                              imageUrl: state.carouselItems[itemIndex].imgUrl,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) =>
                                      CircularProgressIndicator.adaptive(),
                              errorWidget:
                                  (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                    options: FlutterCarouselOptions(
                      height: 180.0,
                      autoPlay: true,
                      showIndicator: true,
                      floatingIndicator: true,
                      enlargeCenterPage: true,
                    ),
                  ),
                ),

                SizedBox(height: 16),

                SizedBox(height: 16),
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
                    Text(
                      'See All',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                GridView.builder(
                  itemCount: state.products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItem(productItem: state.products[index]);
                  },
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
