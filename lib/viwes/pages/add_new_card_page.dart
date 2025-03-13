import 'package:ecommerce_app/models/add_new_card_model.dart';
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
    final cubit = BlocProvider.of<AddNewCardCubit>(context);
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
                LabelWithTextFieldNewCard(
                  label: 'Card Number',
                  controller: _cardNumberController,
                  icon: Icons.credit_card,
                  hintText: 'Enter card number',
                ),
                const SizedBox(height: 20),
                LabelWithTextFieldNewCard(
                  label: 'Card Holder Name',
                  controller: _cardHolderNameController,
                  icon: Icons.person,
                  hintText: 'Enter card holder name',
                ),
                const SizedBox(height: 20),
                LabelWithTextFieldNewCard(
                  label: 'Expiry Date',
                  controller: _expiryDateController,
                  icon: Icons.date_range,
                  hintText: 'Enter expiry date',
                ),
                const SizedBox(height: 20),
                LabelWithTextFieldNewCard(
                  label: 'CVV',
                  controller: _cvvController,
                  icon: Icons.password,
                  hintText: 'Enter cvv',
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: BlocConsumer<AddNewCardCubit, AddNewCardState>(
                    bloc: cubit,

                    listenWhen:
                        (previous, current) =>
                            current is AddNewCardLoded ||
                            current is AddNewCardError,
                    listener: (context, state) {
                      if (state is AddNewCardLoded) {
                        Navigator.pop(context);
                      }
                      if (state is AddNewCardError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    buildWhen:
                        (previous, current) =>
                            current is AddNewCardLoading ||
                            current is AddNewCardError ||
                            current is AddNewCardLoded,
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
                            PaymentCardModel(
                              id: DateTime.now().toIso8601String(),
                              cardNumber: _cardNumberController.text,
                              cardHolderName: _cardHolderNameController.text,
                              expiryDate: _expiryDateController.text,
                              cvvCode: _cvvController.text,
                            ),
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
