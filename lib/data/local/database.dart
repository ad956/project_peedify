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

  Future<int> createTemplate(TemplatesCompanion template) =>
      into(templates).insert(template);

  Future<int> addTemplateColumn(TemplateColumnsCompanion column) =>
      into(templateColumns).insert(column);

  Future<List<Template>> getAllTemplates() => select(templates).get();

  Future<List<TemplateColumn>> getColumnsForTemplate(int templateId) =>
      (select(templateColumns)..where((c) => c.templateId.equals(templateId)))
          .get();
}
