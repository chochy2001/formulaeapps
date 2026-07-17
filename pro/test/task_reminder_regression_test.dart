import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
    'saving reminder and due dates preserves completion and restores them',
    () async {
      final reminder = DateTime(2026, 8, 10, 9, 30);
      final dueDate = DateTime(2026, 8, 15, 17);
      final tasks = TaskData();
      await Future<void>.delayed(Duration.zero);
      tasks.deleteAllTasks();
      final task = Task(name: 'Terminar informe', isDone: true);
      tasks.addTask(task);

      task.reminderDateTime = reminder;
      task.dueDate = dueDate;
      await tasks.saveTask(task);

      expect(task.isDone, isTrue);

      final restored = TaskData();
      await Future<void>.delayed(Duration.zero);
      expect(restored.tasks, hasLength(1));
      expect(restored.tasks.single.name, 'Terminar informe');
      expect(restored.tasks.single.isDone, isTrue);
      expect(restored.tasks.single.reminderDateTime, reminder);
      expect(restored.tasks.single.dueDate, dueDate);
    },
  );
}
