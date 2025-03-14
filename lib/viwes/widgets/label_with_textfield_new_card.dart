import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:flutter/material.dart';

class LabelWithTextFieldNewCard extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final String hintText;

  const LabelWithTextFieldNewCard({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    required this.hintText,
  });

  @override
  State<LabelWithTextFieldNewCard> createState() =>
      _LabelWithTextFieldNewCardState();
}

class _LabelWithTextFieldNewCardState extends State<LabelWithTextFieldNewCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.controller,
          validator: (value) => value!.isEmpty ? 'Required' : null,

          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            prefixIconColor: AppColors.grey,
            hintText: widget.hintText,
            fillColor: AppColors.grey1,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.red),
            ),
          ),
        ),
      ],
    );
  }
}
