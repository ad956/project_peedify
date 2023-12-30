import 'package:flutter/material.dart';

class BillDetailsForm extends StatefulWidget {
  @override
  _BillDetailsFormState createState() => _BillDetailsFormState();
}

class _BillDetailsFormState extends State<BillDetailsForm> {
  final List<Map<String, String>> billDetailsList = [];
  final _formKey = GlobalKey<FormState>();

  String sNo = '';
  String description = '';
  String measurement = '';
  String squareFeet = '';
  String qty = '';
  String rate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'S.No'),
                onChanged: (value) {
                  sNo = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Measurement'),
                onChanged: (value) {
                  measurement = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'S.Feet'),
                onChanged: (value) {
                  squareFeet = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Qty'),
                onChanged: (value) {
                  qty = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rate'),
                onChanged: (value) {
                  rate = value;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    double amount = double.parse(squareFeet) *
                        double.parse(qty) *
                        double.parse(rate);
                    String amountString = amount.toStringAsFixed(2);

                    Map<String, String> billDetails = {
                      'S.No': sNo,
                      'Description': description,
                      'Measurement': measurement,
                      'S.Feet': squareFeet,
                      'Qty': qty,
                      'Rate': rate,
                      'Amount': amountString,
                    };

                    billDetailsList.add(billDetails);

                    _formKey.currentState!.reset();

                    print('Bill Details Added: $billDetailsList');
                  }
                },
                child: const Text('Add Bill Details'),
              ),
              const SizedBox(height: 16.0),
              Text('Added Bill Details: $billDetailsList'),
            ],
          ),
        ),
      ),
    );
  }
}
