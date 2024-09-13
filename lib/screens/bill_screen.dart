import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:peedify/data/local/database.dart';
import 'package:peedify/widgets/build_date_field.dart';
import 'package:peedify/widgets/build_text_field.dart';

class BillScreen extends StatefulWidget {
  final Template template;
  final List<TemplateColumn> templateColumns; // Updated to accept columns

  const BillScreen({
    Key? key,
    required this.template,
    required this.templateColumns,
  }) : super(key: key);

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController billNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    billNumberController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context, String message,
      {Color? backgroundColor}) {
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

      print('Template Columns: ${widget.templateColumns}');

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Centered shop name
              pw.Center(
                child: pw.Text(
                  widget.template.shopName,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),

              // Address and Phone Number in one row, aligned on both ends
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Shop Address: ${widget.template.shopAddress}',
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                  pw.Text(
                    'Contact: ${widget.template.shopPhone}',
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              // "Invoice Details" Header
              pw.Text(
                'INVOICE DETAILS',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),

              // Table with headers from the template columns
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Table Header (Column names from the template columns)
                  pw.TableRow(
                    children: [
                      for (var column in widget.templateColumns)
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            column.columnName, // Column name
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Mock Data (5 rows of sample data)
                  for (int i = 0; i < 5; i++)
                    pw.TableRow(
                      children: [
                        for (var column in widget.templateColumns)
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                                '${column.columnName} $i'), // Sample data
                          ),
                      ],
                    ),
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

      _showSnackBar(context, 'PDF created successfully!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Invoice', style: theme.textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Text(
                  'Invoice Details',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: theme.cardTheme.elevation,
                  shape: theme.cardTheme.shape,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                    icon: Icon(Icons.picture_as_pdf,
                        color: colorScheme.onPrimary),
                    label: Text('Generate PDF',
                        style: TextStyle(color: colorScheme.onPrimary)),
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
