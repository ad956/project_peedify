import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

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

                      // GoRouter.of(context).go("/bill");
                      generatePdf(
                        nameController.text,
                        addressController.text,
                        billNumberController.text,
                        dateController.text,
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> generatePdf(
      String name, String address, String billNumber, String date) async {
    // Create a new PDF document
    final PdfDocument document = PdfDocument();

    // Create a new page
    final PdfPage page = document.pages.add();

    // Create a new font
    final PdfStandardFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);

    // Create a new text element
    final PdfTextElement textElement = PdfTextElement(
      text: 'Name: $name',
      font: font,
      brush: PdfBrushes.black,
    );

    // Draw the text element on the page
    page.graphics.drawString(
      textElement.text,
      textElement.font,
      bounds: Rect.fromLTWH(
          0, 0, page.getClientSize().width, page.getClientSize().height),
    );

    // Create another text element
    final PdfTextElement textElement2 = PdfTextElement(
      text: 'Address: $address',
      font: font,
      brush: PdfBrushes.black,
    );

    // Draw the text element on the page
    page.graphics.drawString(
      textElement2.text,
      textElement2.font,
      bounds: Rect.fromLTWH(
          0, 50, page.getClientSize().width, page.getClientSize().height),
    );

    // Create another text element
    final PdfTextElement textElement3 = PdfTextElement(
      text: 'Bill Number: $billNumber',
      font: font,
      brush: PdfBrushes.black,
    );

    // Draw the text element on the page
    page.graphics.drawString(
      textElement3.text,
      textElement3.font,
      bounds: Rect.fromLTWH(
          0, 100, page.getClientSize().width, page.getClientSize().height),
    );

    // Create another text element
    final PdfTextElement textElement4 = PdfTextElement(
      text: 'Date: $date',
      font: font,
      brush: PdfBrushes.black,
    );

    // Draw the text element on the page
    page.graphics.drawString(
      textElement4.text,
      textElement4.font,
      bounds: Rect.fromLTWH(
          0, 150, page.getClientSize().width, page.getClientSize().height),
    );

    // Save the PDF
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final File file = File('${documentsDirectory.path}/path_to_your_file.pdf');
    final List<int> bytes = await document.save();
    await file.writeAsBytes(bytes);
  }
}
