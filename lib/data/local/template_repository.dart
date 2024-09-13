import 'database.dart';

class TemplateRepository {
  final AppDatabase _db;

  TemplateRepository(this._db);

  Future<int> createTemplate(String name, String shopName, String shopAddress,
      String shopPhone) async {
    return await _db.createTemplate(TemplatesCompanion.insert(
      name: name,
      shopName: shopName,
      shopAddress: shopAddress,
      shopPhone: shopPhone,
    ));
  }

  Future<void> addColumnToTemplate(
      int templateId, String columnName, int orderIndex) async {
    await _db.addTemplateColumn(TemplateColumnsCompanion.insert(
      templateId: templateId,
      columnName: columnName,
      orderIndex: orderIndex,
    ));
  }

  Future<List<Template>> getAllTemplates() async {
    return await _db.getAllTemplates();
  }

  Future<List<TemplateColumn>> getColumnsForTemplate(int templateId) async {
    return await _db.getColumnsForTemplate(templateId);
  }
}
