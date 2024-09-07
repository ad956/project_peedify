import 'package:flutter/material.dart';

Widget buildTextField(
    {required TextEditingController controller, required String label}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.deepPurple),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.deepPurple),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
      ),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter $label';
      }
      return null;
    },
  );
}
