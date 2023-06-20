import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.isNumber = false});

  final TextEditingController controller;
  final String labelText;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }
}
