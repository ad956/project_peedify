import 'package:drift/drift.dart';

import 'database.dart';

class TemplateRepository {
  final AppDatabase _db;

  TemplateRepository(this._db);

  Future<int> createTemplate(String name, String shopName, String shopAddress,
      String shopPhone) async {
    try {
      return await _db.createTemplate(TemplatesCompanion.insert(
        name: name,
        shopName: shopName,
        shopAddress: shopAddress,
        shopPhone: shopPhone,
      ));
    } catch (error) {
      throw Exception('Error creating template: $error');
    }
  }

  Future<void> addColumnToTemplate(
      int templateId, String columnName, int orderIndex) async {
    try {
      await _db.addTemplateColumn(TemplateColumnsCompanion.insert(
        templateId: templateId,
        columnName: columnName,
        orderIndex: orderIndex,
      ));
    } catch (error) {
      throw Exception('Error adding column to template: $error');
    }
  }

  Future<List<Template>> getAllTemplates() async {
    try {
      return await _db.getAllTemplates();
    } catch (error) {
      throw Exception('Error fetching templates: $error');
    }
  }

  Future<List<TemplateColumn>> getColumnsForTemplate(int templateId) async {
    try {
      return await _db.getColumnsForTemplate(templateId);
    } catch (error) {
      throw Exception('Error fetching template columns: $error');
    }
  }

  Future<void> deleteTemplate(int templateId) async {
    try {
      await _db.deleteTemplateWithColumns(templateId);
    } catch (error) {
      throw Exception('Error deleting template: $error');
    }
  }

  Future<void> updateTemplate(int templateId, String newName,
      String newShopName, String newShopAddress, String newShopPhone) async {
    try {
      final updated = await _db.updateTemplate(
        templateId,
        TemplatesCompanion(
          name: Value(newName),
          shopName: Value(newShopName),
          shopAddress: Value(newShopAddress),
          shopPhone: Value(newShopPhone),
        ),
      );
      if (!updated) {
        throw Exception('Template not found or no changes made.');
      }
    } catch (error) {
      throw Exception('Error updating template: $error');
    }
  }
}
