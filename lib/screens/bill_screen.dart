import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/build_date_field.dart';
import '../widgets/build_text_field.dart';
import 'package:pdf/widgets.dart' as pw;

class BillDetailsForm extends StatelessWidget {
  final List<Map<String, String>> billDetailsList = [];

  final _formKey = GlobalKey<FormState>();

  final String sNo = '';
  final String description = '';
  final String measurement = '';
  final String squareFeet = '';
  final String qty = '';
  final String rate = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController billNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  BillDetailsForm({super.key});

  void _showSnackBar(BuildContext context, String message,
      {Color backgroundColor = Colors.green}) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Future<void> _generatePDF(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final pdf = pw.Document();

      // Add header information
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Furniture Mart',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.Text('Address: Some Address',
                  style: const pw.TextStyle(fontSize: 12)),
              pw.Text('Contact: 13444444',
                  style: const pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 20),
              pw.Text('Invoice Details',
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.TableHelper.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Client Name', 'Address', 'Bill Number', 'Date'],
                  <String>[
                    nameController.text,
                    addressController.text,
                    billNumberController.text,
                    dateController.text,
                  ],
                ],
              ),
            ],
          ),
        ),
      );

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/invoice.pdf");
      await file.writeAsBytes(await pdf.save());

      await OpenFile.open(file.path);

      if (context.mounted) {
        _showSnackBar(context, 'PDF created successfully!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Generate Invoice',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 20.0),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        buildTextField(
                          controller: nameController,
                          label: 'M/s (Name of Client)',
                        ),
                        const SizedBox(height: 16.0),
                        buildTextField(
                          controller: addressController,
                          label: 'Address',
                        ),
                        const SizedBox(height: 16.0),
                        buildTextField(
                          controller: billNumberController,
                          label: 'No: (Bill Number)',
                        ),
                        const SizedBox(height: 16.0),
                        buildDateField(
                          context,
                          controller: dateController,
                          label: 'Date',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Generate PDF',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _generatePDF(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: Colors.deepPurple,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
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
