import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 120,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey.shade200,
              ),
              child: Image.network(productItem.imgUrl, fit: BoxFit.contain),
            ),
            Positioned(
              top: 2,
              right: 2,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
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
          ).textTheme.labelMedium!.copyWith(color: Colors.grey),
        ),
        Text(
          '\$${productItem.price}',
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
