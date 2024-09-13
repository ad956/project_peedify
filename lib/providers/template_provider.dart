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
    _templates = await _repository.getAllTemplates();
    notifyListeners();
  }

  Future<void> createTemplate(String name, String shopName, String shopAddress,
      String shopPhone) async {
    await _repository.createTemplate(name, shopName, shopAddress, shopPhone);
    await _loadTemplates();
  }
}
