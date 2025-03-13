import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_model/checkout_state/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyShippingAndPayment extends StatelessWidget {
  final String title;
  const EmptyShippingAndPayment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.addNewCardRoute).then((value) {
          checkoutCubit.getCartItems();
        });
      },
      child: Container(
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
      ),
    );
  }
}
