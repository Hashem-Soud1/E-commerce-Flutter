import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/view_model/home_state/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              height: 110,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey.shade200,
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: productItem.imgUrl,
                  fit: BoxFit.contain,

                  placeholder:
                      (context, url) => CircularProgressIndicator.adaptive(),

                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: 2,
              right: 2,

              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white60,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    bloc: homeCubit,
                    buildWhen:
                        (previous, current) =>
                            (current is SetFavoriteSuccess &&
                                current.productId == productItem.id) ||
                            (current is SetFavoriteError &&
                                current.productId == productItem.id) ||
                            (current is SetFavoriteLoading &&
                                current.productId == productItem.id),
                    builder: (context, state) {
                      if (state is SetFavoriteLoading) {
                        return const CircularProgressIndicator.adaptive();
                      } else if (state is SetFavoriteSuccess) {
                        return state.isFavorite
                            ? InkWell(
                              onTap:
                                  () async =>
                                      await homeCubit.setFavorite(productItem),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            )
                            : InkWell(
                              onTap:
                                  () async =>
                                      await homeCubit.setFavorite(productItem),
                              child: const Icon(Icons.favorite_border),
                            );
                      }
                      return InkWell(
                        onTap:
                            () async =>
                                await homeCubit.setFavorite(productItem),
                        child:
                            productItem.isFavorite
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : Icon(Icons.favorite_border),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          productItem.name,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          productItem.category,
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: Colors.grey),
        ),
        Text(
          '\$${productItem.price}',
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
