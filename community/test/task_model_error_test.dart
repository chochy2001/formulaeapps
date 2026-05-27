import 'package:flutter_test/flutter_test.dart';

import 'package:formulae/models/task.dart';

void main() {
  group('Task', () {
    test('round-trips through toMap and fromMap', () {
      final task = Task(name: 'Study integrals', isDone: false);
      final restored = Task.fromMap(
        '{"name":"Study integrals","isDone":false}',
      );

      expect(restored.name, task.name);
      expect(restored.isDone, task.isDone);
    });

    test('toggleDone flips isDone', () {
      final task = Task(name: 'Review derivatives');
      expect(task.isDone, isFalse);

      task.toggleDone();
      expect(task.isDone, isTrue);

      task.toggleDone();
      expect(task.isDone, isFalse);
    });

    test('fromMap throws FormatException on malformed JSON', () {
      expect(
        () => Task.fromMap('not-json'),
        throwsA(isA<FormatException>()),
      );
    });

    test('fromMap throws when required field is missing', () {
      expect(
        () => Task.fromMap('{"isDone":false}'),
        throwsA(isA<TypeError>()),
      );
    });

    test('fromMap throws when field has wrong type', () {
      expect(
        () => Task.fromMap('{"name":123,"isDone":false}'),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
