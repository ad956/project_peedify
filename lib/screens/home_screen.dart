import 'package:flutter/material.dart';
import 'package:peedify/providers/template_provider.dart';
import 'package:provider/provider.dart';
import 'package:peedify/widgets/app_header.dart';
import 'package:peedify/widgets/available_template.dart';
import 'package:peedify/widgets/empty_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TemplateNotifier>(
      builder: (context, templateNotifier, child) {
        final isEmpty = templateNotifier.templates.isEmpty;
        return Scaffold(
          appBar: const AppHeader(),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: isEmpty
                      ? const EmptyStateWidget()
                      : const AvailableTemplates(),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showCreateTemplateDialog(context, templateNotifier);
            },
            child: const Icon(Icons.add_rounded, size: 30),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  void _showCreateTemplateDialog(
      BuildContext context, TemplateNotifier templateNotifier) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _CreateTemplateDialog(templateNotifier: templateNotifier);
      },
    );
  }
}

class _CreateTemplateDialog extends StatefulWidget {
  final TemplateNotifier templateNotifier;

  const _CreateTemplateDialog({Key? key, required this.templateNotifier})
      : super(key: key);

  @override
  State<_CreateTemplateDialog> createState() => _CreateTemplateDialogState();
}

class _CreateTemplateDialogState extends State<_CreateTemplateDialog> {
  String name = '';
  String shopName = '';
  String shopAddress = '';
  String shopPhone = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return AlertDialog(
      title: Text('Create New Template', style: textTheme.headlineSmall),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Template Name', (value) => name = value),
            const SizedBox(height: 16),
            _buildTextField('Shop Name', (value) => shopName = value),
            const SizedBox(height: 16),
            _buildTextField('Shop Address', (value) => shopAddress = value),
            const SizedBox(height: 16),
            _buildTextField('Shop Phone', (value) => shopPhone = value),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel', style: textTheme.labelLarge),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Next', style: textTheme.labelLarge),
          onPressed: () {
            Navigator.of(context).pop();
            _showColumnNamesDialog(
                context, name, shopName, shopAddress, shopPhone);
          },
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  TextField _buildTextField(String labelText, Function(String) onChanged) {
    return TextField(
      decoration: InputDecoration(labelText: labelText),
      onChanged: onChanged,
    );
  }

  void _showColumnNamesDialog(BuildContext context, String name,
      String shopName, String shopAddress, String shopPhone) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _ColumnNamesDialog(
          templateNotifier: widget.templateNotifier,
          name: name,
          shopName: shopName,
          shopAddress: shopAddress,
          shopPhone: shopPhone,
        );
      },
    );
  }
}

class _ColumnNamesDialog extends StatefulWidget {
  final TemplateNotifier templateNotifier;
  final String name;
  final String shopName;
  final String shopAddress;
  final String shopPhone;

  const _ColumnNamesDialog({
    Key? key,
    required this.templateNotifier,
    required this.name,
    required this.shopName,
    required this.shopAddress,
    required this.shopPhone,
  }) : super(key: key);

  @override
  State<_ColumnNamesDialog> createState() => _ColumnNamesDialogState();
}

class _ColumnNamesDialogState extends State<_ColumnNamesDialog> {
  final List<String> columnNames = [];
  final TextEditingController columnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return AlertDialog(
      title: Text('Add Column Names', style: textTheme.headlineSmall),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var column in columnNames)
              ListTile(
                title: Text(column),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      columnNames.remove(column);
                    });
                  },
                ),
              ),
            const SizedBox(height: 16),
            TextField(
              controller: columnController,
              decoration: const InputDecoration(labelText: 'Column Name'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final newColumnName = columnController.text.trim();
                if (newColumnName.isNotEmpty) {
                  setState(() {
                    columnNames.add(newColumnName);
                  });
                  columnController.clear();
                }
              },
              child: const Text('Add Column'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel', style: textTheme.labelLarge),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Create Template', style: textTheme.labelLarge),
          onPressed: () {
            print('Columns being saved uin home screen : $columnNames');
            widget.templateNotifier.createTemplateWithColumns(
              widget.name,
              widget.shopName,
              widget.shopAddress,
              widget.shopPhone,
              columnNames,
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
