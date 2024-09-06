import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

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
                decoration: const InputDecoration(labelText: 'M/s (Name of Client)'),
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
                decoration: const InputDecoration(labelText: 'No : (Bill Number)'),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Generate PDF
                    final pdf = pw.Document();

                    pdf.addPage(
                      pw.Page(
                        build: (pw.Context context) => pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('Client: ${nameController.text}'),
                            pw.Text('Address: ${addressController.text}'),
                            pw.Text('Bill Number: ${billNumberController.text}'),
                            pw.Text('Date: ${dateController.text}'),
                          ],
                        ),
                      ),
                    );

                    // Save the PDF
                    final output = await getTemporaryDirectory();
                    final file = File("${output.path}/example.pdf");
                    await file.writeAsBytes(await pdf.save());

                    // Open the PDF
                    await OpenFile.open(file.path);

                    // Show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('PDF created successfully!')),
                    );
                  }
                },
                child: const Text('Generate PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}