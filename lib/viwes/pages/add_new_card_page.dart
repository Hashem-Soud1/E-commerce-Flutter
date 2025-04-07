import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:ecommerce_app/view_model/add_new_card_cudit/add_new_card_cubit.dart';
import 'package:ecommerce_app/viwes/widgets/label_with_textfield_new_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Card')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelWithTextField(
                  label: 'Card Number',
                  controller: _cardNumberController,
                  prefixIcon: Icons.credit_card,
                  hintText: 'Enter card number',
                ),
                const SizedBox(height: 20),
                LabelWithTextField(
                  label: 'Card Holder Name',
                  controller: _cardHolderNameController,
                  prefixIcon: Icons.person,
                  hintText: 'Enter card holder name',
                ),
                const SizedBox(height: 20),
                LabelWithTextField(
                  label: 'Expiry Date',
                  controller: _expiryDateController,
                  prefixIcon: Icons.date_range,
                  hintText: 'Enter expiry date',
                ),
                const SizedBox(height: 20),
                LabelWithTextField(
                  label: 'CVV',
                  controller: _cvvController,
                  prefixIcon: Icons.password,
                  hintText: 'Enter cvv',
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
                    bloc: cubit,

                    listenWhen:
                        (previous, current) =>
                            current is AddNewCardSuccess ||
                            current is AddNewCardFailure,
                    listener: (context, state) {
                      if (state is AddNewCardSuccess) {
                        Navigator.pop(context);
                      }
                      if (state is AddNewCardFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    buildWhen:
                        (previous, current) =>
                            current is AddNewCardLoading ||
                            current is AddNewCardFailure ||
                            current is AddNewCardSuccess,
                    builder: (context, state) {
                      if (state is AddNewCardLoading) {
                        ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                          ),
                          child: const CircularProgressIndicator.adaptive(),
                        );
                      }

                      return ElevatedButton(
                        onPressed: () {
                          cubit.addNewCard(
                            _cardNumberController.text,
                            _cardHolderNameController.text,
                            _expiryDateController.text,
                            _cvvController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                        ),
                        child: const Text('Add Card'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
