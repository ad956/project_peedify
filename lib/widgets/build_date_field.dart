import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildDateField(BuildContext context,
    {required TextEditingController controller, required String label}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: Icon(Icons.calendar_today,
          color: Theme.of(context).colorScheme.primary),
    ),
    readOnly: true,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Theme.of(context).colorScheme.primary,
                    onPrimary: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            child: child!,
          );
        },
      );
      if (pickedDate != null) {
        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
        controller.text = formattedDate;
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
