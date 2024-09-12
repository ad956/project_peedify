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
      {Color? backgroundColor}) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.secondary,
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Invoice'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invoice Details',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Card(
                  elevation: theme.cardTheme.elevation,
                  shape: theme.cardTheme.shape,
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
                    icon: Icon(
                      Icons.picture_as_pdf,
                      color: colorScheme.onPrimary,
                    ),
                    label: Text(
                      'Generate PDF',
                      style: TextStyle(color: colorScheme.onPrimary),
                    ),
                    onPressed: () => _generatePDF(context),
                    style: theme.elevatedButtonTheme.style,
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
