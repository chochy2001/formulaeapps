import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/models_provider.dart';

void main() {
  test('ModelsProvider updates the selected model and loads the stub list',
      () async {
    var notifications = 0;
    final provider = ModelsProvider()..addListener(() => notifications++);

    provider.setCurrentModel('openai/gpt-4o-mini');
    final models = await provider.getAllModels();

    expect(provider.getCurrentModel, 'openai/gpt-4o-mini');
    expect(notifications, 1);
    expect(models, hasLength(1));
    expect(models.single.id, 'openai/gpt-4o-mini');
    expect(provider.getModelsList, same(models));
  });
}
