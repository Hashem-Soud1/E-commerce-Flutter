import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:flutter/material.dart';

class LocationItem extends StatelessWidget {
  final LocationItemModel location;
  final VoidCallback onTap;
  final Color borderColor;

  const LocationItem({
    super.key,
    required this.location,
    required this.onTap,
    this.borderColor = AppColors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.city,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${location.city}, ${location.country}',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(radius: 55, backgroundColor: borderColor),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider(
                      location.imgUrl,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
