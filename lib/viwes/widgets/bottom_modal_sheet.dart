import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_model/add_new_card_cudit/add_new_card_cubit.dart';
import 'package:ecommerce_app/viwes/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomModalSheet extends StatelessWidget {
  const CustomBottomModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentMethodsCubit = BlocProvider.of<AddNewCardCubit>(context);

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 36.0,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Methods',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              BlocBuilder(
                bloc: paymentMethodsCubit,
                buildWhen:
                    (previous, current) =>
                        current is PaymentCardLoading ||
                        current is PyamentCardLoded ||
                        current is PaymentCardError,
                builder: (_, state) {
                  if (state is PaymentCardLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is PyamentCardLoded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.paymentCards.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final paymentCard = state.paymentCards[index];
                        return Card(
                          elevation: 0,
                          child: ListTile(
                            leading: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.grey2,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 8.0,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/1200px-MasterCard_Logo.svg.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(paymentCard.cardNumber),
                            subtitle: Text(paymentCard.cardHolderName),
                          ),
                        );
                      },
                    );
                  } else if (state is PaymentCardError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.addNewCardRoute);
                },
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey2,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.add),
                      ),
                    ),
                    title: const Text('Add New Card'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              MainButton(text: 'Confirm Payemnt', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
