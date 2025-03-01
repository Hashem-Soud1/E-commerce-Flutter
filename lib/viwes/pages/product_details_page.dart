import 'package:ecommerce_app/view_model/product_details/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ProductDetailsCubit();
        cubit.fetchProductDetails(productId);
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Product Details')),
        body: Column(
          children: [
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                if (state is ProductDetailsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductDetailsLoaded) {
                  debugPrint(state.product.toString());
                  return Column(
                    children: [
                      Image.network(state.product.imgUrl),
                      Text(state.product.name),
                      Text(state.product.price.toString()),
                    ],
                  );
                } else if (state is ProductDetailsError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
