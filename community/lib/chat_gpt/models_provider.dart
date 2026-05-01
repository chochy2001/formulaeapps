import 'package:flutter/cupertino.dart';

import '../chat_gpt/export_chat_gpt.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = 'gpt-3.5-turbo';

  String get getCurrentModel => currentModel;

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList => modelsList;

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}
