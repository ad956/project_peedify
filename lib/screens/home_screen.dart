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
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
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
                  'Generate Invoice',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
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
                        _buildTextField(
                          controller: nameController,
                          label: 'M/s (Name of Client)',
                        ),
                        const SizedBox(height: 16.0),
                        _buildTextField(
                          controller: addressController,
                          label: 'Address',
                        ),
                        const SizedBox(height: 16.0),
                        _buildTextField(
                          controller: billNumberController,
                          label: 'No: (Bill Number)',
                        ),
                        const SizedBox(height: 16.0),
                        _buildDateField(
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
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Generate PDF'),
                    onPressed: () async {
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
                                        fontSize: 24,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text('Address: Some Address',
                                    style: pw.TextStyle(fontSize: 12)),
                                pw.Text('Contact: 13444444',
                                    style: pw.TextStyle(fontSize: 12)),
                                pw.SizedBox(height: 20),
                                pw.Text('Invoice Details',
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(height: 10),
                                pw.Table.fromTextArray(
                                  context: context,
                                  data: <List<String>>[
                                    <String>[
                                      'Client Name',
                                      'Address',
                                      'Bill Number',
                                      'Date'
                                    ],
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

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('PDF created successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
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

  Widget _buildTextField(
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

  Widget _buildDateField(BuildContext context,
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
}
