import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/add_new_card_model.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_model/add_new_card_cudit/add_new_card_cubit.dart';
import 'package:ecommerce_app/view_model/checkout_state/checkout_cubit.dart';
import 'package:ecommerce_app/viwes/widgets/bottom_modal_sheet.dart';
import 'package:ecommerce_app/viwes/widgets/checkout_headlines_item.dart';
import 'package:ecommerce_app/viwes/widgets/empty_shipping__payment.dart';
import 'package:ecommerce_app/viwes/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  Widget _buildPyamentMethod(
    PaymentCardModel? firstCardChosen,
    BuildContext context,
  ) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    if (firstCardChosen != null) {
      return PaymentMethodItem(
        paymentCard: firstCardChosen,
        onItemTapped: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                child: BlocProvider(
                  create: (context) {
                    return PaymentMethodsCubit()..fetchPaymentMethods();
                  },
                  child: const CustomBottomModalSheet(),
                ),
              );
            },
          ).then((onValue) {
            checkoutCubit.getCartItems();
          });
        },
      );
    } else {
      return const EmptyShippingAndPayment(
        title: 'Add Payment Method',
        isPayment: true,
      );
    }
  }

  Widget _buildAddresMethod(
    LocationItemModel? chosenAddress,
    BuildContext context,
  ) {
    if (chosenAddress != null) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: chosenAddress.imgUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chosenAddress.city,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${chosenAddress.city}, ${chosenAddress.country}',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ],
      );
    } else {
      return const EmptyShippingAndPayment(
        title: 'Add Address',
        isPayment: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckoutCubit>(
          create: (context) => CheckoutCubit()..getCartItems(),
        ),
        BlocProvider(create: (context) => PaymentMethodsCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<CheckoutCubit>(context);

            return BlocBuilder<CheckoutCubit, CheckoutState>(
              bloc: cubit,
              buildWhen:
                  (previous, current) =>
                      current is CheckoutLoaded ||
                      current is CheckoutLoading ||
                      current is CheckoutError,
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is CheckoutError) {
                  return Center(child: Text(state.message));
                } else if (state is CheckoutLoaded) {
                  final PaymentCardModel? cardChosen = state.CardChoosen;
                  final LocationItemModel? addressChosen =
                      state.LocationChoosen;

                  final cartItems = state.cartItems;
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            CheckoutHeadlinesItem(
                              title: 'Address',
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.locationRoute)
                                    .then((value) async {
                                      await cubit.getCartItems();
                                    });
                              },
                            ),
                            const SizedBox(height: 16.0),
                            _buildAddresMethod(addressChosen, context),
                            const SizedBox(height: 16.0),
                            CheckoutHeadlinesItem(
                              title: 'Products',
                              numOfProducts: state.numOfProducts,
                            ),
                            const SizedBox(height: 16.0),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartItems.length,
                              separatorBuilder: (context, index) {
                                return Divider(color: AppColors.grey2);
                              },
                              itemBuilder: (context, index) {
                                final cartItem = cartItems[index];
                                return Row(
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: AppColors.grey2,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: cartItem.product.imgUrl,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartItem.product.name,
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleMedium,
                                          ),
                                          const SizedBox(height: 4.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  text: 'Size: ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        color: AppColors.grey1,
                                                      ),
                                                  children: [
                                                    TextSpan(
                                                      text: cartItem.size.name,
                                                      style:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                '\$${cartItem.totalPrice.toStringAsFixed(1)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 16.0),
                            const CheckoutHeadlinesItem(
                              title: 'Payment Methods',
                            ),
                            const SizedBox(height: 16.0),
                            _buildPyamentMethod(cardChosen, context),
                            const SizedBox(height: 16.0),
                            Divider(color: AppColors.grey),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: AppColors.grey),
                                ),
                                Text(
                                  '\$${state.totalAmount.toStringAsFixed(1)}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 40.0),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: AppColors.white,
                                ),
                                child: const Text('Proceed to Buy'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('Something went wrong!'));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
