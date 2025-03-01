import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/view_model/category_state/cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        } else if (state is CategoryLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final category = state.categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: () {},
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: category.bgColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32,
                        horizontal: 16,
                      ),
                      child: Column(
                        children: [
                          Text(
                            category.name,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              color: category.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${category.productsCount} Products',
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge!.copyWith(
                              color: category.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: state.categories.length,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
