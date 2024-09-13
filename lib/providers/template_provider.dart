import 'package:flutter/foundation.dart';
import 'package:peedify/data/local/database.dart';
import 'package:peedify/data/local/template_repository.dart';

class TemplateNotifier extends ChangeNotifier {
  final TemplateRepository _repository;
  List<Template> _templates = [];

  TemplateNotifier(this._repository) {
    _loadTemplates();
  }

  List<Template> get templates => _templates;

  Future<void> _loadTemplates() async {
    try {
      _templates = await _repository.getAllTemplates();
    } catch (error) {
      debugPrint("Error loading templates: $error");
    }
    notifyListeners();
  }

  Future<void> createTemplateWithColumns(String name, String shopName,
      String shopAddress, String shopPhone, List<String> columnNames) async {
    try {
      final templateId = await _repository.createTemplate(
          name, shopName, shopAddress, shopPhone);

      for (int i = 0; i < columnNames.length; i++) {
        await _repository.addColumnToTemplate(templateId, columnNames[i], i);
      }

      await _loadTemplates();
    } catch (error) {
      debugPrint("Error creating template with columns: $error");
    }
  }

  Future<void> deleteTemplate(int templateId) async {
    try {
      await _repository.deleteTemplate(templateId);

      // Reload templates after deletion.
      await _loadTemplates();
    } catch (error) {
      // Handle any potential errors during deletion.
      debugPrint("Error deleting template: $error");
    }
  }

  Future<void> updateTemplate(int templateId, String newName,
      String newShopName, String newShopAddress, String newShopPhone) async {
    try {
      await _repository.updateTemplate(
          templateId, newName, newShopName, newShopAddress, newShopPhone);

      await _loadTemplates();
    } catch (error) {
      debugPrint("Error updating template: $error");
    }
  }

  Future<void> refreshTemplates() async {
    await _loadTemplates();
  }
}
