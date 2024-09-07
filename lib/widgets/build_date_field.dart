import 'package:flutter/material.dart';

Widget buildDateField(BuildContext context,
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
      suffixIcon: const Icon(Icons.calendar_today, color: Colors.deepPurple),
    ),
    readOnly: true,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        controller.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      }
    },
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter the date';
      }
      return null;
    },
  );
}
