import 'package:drift/drift.dart';

part 'database.g.dart';

class Templates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get shopName => text()();
  TextColumn get shopAddress => text()();
  TextColumn get shopPhone => text()();
}

class TemplateColumns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().references(Templates, #id)();
  TextColumn get columnName => text()();
  IntColumn get orderIndex => integer()();
}

@DriftDatabase(tables: [Templates, TemplateColumns])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  // Create a new template
  Future<int> createTemplate(TemplatesCompanion template) =>
      into(templates).insert(template);

  // Add a column to a template
  Future<int> addTemplateColumn(TemplateColumnsCompanion column) =>
      into(templateColumns).insert(column);

  // Get all templates
  Future<List<Template>> getAllTemplates() => select(templates).get();

  // Get columns in order for a given template
  Future<List<TemplateColumn>> getColumnsForTemplate(int templateId) =>
      (select(templateColumns)
            ..where((c) => c.templateId.equals(templateId))
            ..orderBy([(t) => OrderingTerm(expression: t.orderIndex)]))
          .get();

  // Update a specific column of a template
  Future<bool> updateTemplateColumn(
      int columnId, TemplateColumnsCompanion updatedColumnData) async {
    final rowsUpdated = await (update(templateColumns)
          ..where((c) => c.id.equals(columnId)))
        .write(updatedColumnData);

    return rowsUpdated > 0;
  }

  // Delete a template and its related columns
  Future<void> deleteTemplateWithColumns(int templateId) async {
    // Delete columns related to the template first
    await (delete(templateColumns)
          ..where((c) => c.templateId.equals(templateId)))
        .go();

    // Then delete the template
    await (delete(templates)..where((t) => t.id.equals(templateId))).go();
  }

  // Update an existing template
  Future<bool> updateTemplate(
      int templateId, TemplatesCompanion updatedTemplate) async {
    final rowsUpdated = await (update(templates)
          ..where((t) => t.id.equals(templateId)))
        .write(updatedTemplate);

    return rowsUpdated > 0;
  }

  // Delete a specific template
  Future<void> deleteTemplate(int templateId) async {
    await (delete(templates)..where((t) => t.id.equals(templateId))).go();
  }
}
