import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController billNumberController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Peedify"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(labelText: 'M/s (Name of Client)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the client name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: billNumberController,
                  decoration:
                      const InputDecoration(labelText: 'No : (Bill Number)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the bill number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the form data
                      // For example, you can print the data to the console
                      print('Name: ${nameController.text}');
                      print('Address: ${addressController.text}');
                      print('Bill Number: ${billNumberController.text}');
                      print('Date: ${dateController.text}');
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }
}
