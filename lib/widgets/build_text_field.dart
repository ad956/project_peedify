import 'package:flutter/material.dart';

Widget buildTextField(
    {required TextEditingController controller, required String label}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter $label';
      }
      return null;
    },
  );
}
