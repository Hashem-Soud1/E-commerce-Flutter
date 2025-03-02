import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:ecommerce_app/view_model/product_details/cubit/product_details_cubit.dart';
import 'package:ecommerce_app/viwes/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) {
        return ProductDetailsCubit()..fetchProductDetails(productId);
      },
      child: Scaffold(
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          buildWhen: (previous, current) => current is! QuantityCounterLoaded,
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator.adaptive()),
              );
            } else if (state is ProductDetailsError) {
              return Scaffold(body: Center(child: Text(state.message)));
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;
              return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text('Product Details'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                  ],
                ),
                body: Stack(
                  children: [
                    Container(
                      height: size.height * 0.52,
                      width: double.infinity,
                      decoration: BoxDecoration(color: AppColors.grey2),
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          CachedNetworkImage(
                            imageUrl: product.imgUrl,
                            height: size.height * 0.4,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.47),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(36.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: AppColors.yellow,
                                            size: 25,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            product.averageRate.toString(),
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleMedium,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  BlocBuilder<
                                    ProductDetailsCubit,
                                    ProductDetailsState
                                  >(
                                    bloc: BlocProvider.of<ProductDetailsCubit>(
                                      context,
                                    ),
                                    buildWhen:
                                        (previous, current) =>
                                            current is QuantityCounterLoaded ||
                                            current is ProductDetailsLoaded,
                                    builder: (context, state) {
                                      if (state is QuantityCounterLoaded) {
                                        return CounterWidget(
                                          value: state.value,
                                          productId: product.id,
                                          cubit: BlocProvider.of<
                                            ProductDetailsCubit
                                          >(context),
                                        );
                                      } else if (state
                                          is ProductDetailsLoaded) {
                                        return CounterWidget(
                                          value: state.product.quantity,
                                          productId: product.id,
                                          cubit: BlocProvider.of<
                                            ProductDetailsCubit
                                          >(context),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Size',
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children:
                                    ProductSize.values
                                        .map(
                                          (size) => Padding(
                                            padding: const EdgeInsets.only(
                                              top: 6.0,
                                              right: 8.0,
                                            ),
                                            child: InkWell(
                                              onTap: () {},
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.grey2,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    12.0,
                                                  ),
                                                  child: Text(size.name),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                product.description,
                                style: Theme.of(context).textTheme.labelMedium!
                                    .copyWith(color: AppColors.black45),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: '\$',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: product.price.toString(),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge!.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.white,
                                    ),
                                    label: const Text('Add to Cart'),
                                    icon: const Icon(
                                      Icons.shopping_bag_outlined,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Scaffold(
                body: Center(child: Text('Something went wrong!')),
              );
            }
          },
        ),
      ),
    );
  }
}
