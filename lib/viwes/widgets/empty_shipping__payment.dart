import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:flutter/material.dart';

class EmptyShippingAndPayment extends StatelessWidget {
  final String title;
  const EmptyShippingAndPayment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            const Icon(Icons.add, size: 30),
            Text(title, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
