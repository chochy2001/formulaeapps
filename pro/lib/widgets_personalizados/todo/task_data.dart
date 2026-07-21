import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskData extends ChangeNotifier {
  //todo poner tareas en idioma de la app
  List<Task> _tasks = [
    Task(name: 'Mantén presionado para ver datos de la tarea'),
    Task(
      name:
          'Mantén presionado el botón (+ Agregar) para eliminar todas las tareas',
    ),
    Task(name: 'Tarea demo'),
    Task(
      name:
          'Deja presionado el boton de Compartir para compartir la tarea en PDF',
    ),
    Task(
      name:
          'Desliza hacia la derecha para eliminar, compartir o editar la tarea',
    ),
    Task(
      name:
          'Desliza hacia la izquierda para poner un recordatorio y asignar fecha de entrega',
    ),
    Task(name: 'Press and hold to see the data of the task'),
    Task(name: 'Press and hold the button (+ Add) to delete all tasks'),
    Task(name: 'Demo task'),
    Task(name: 'Swipe right to delete, share, or edit the task'),
    Task(name: 'Swipe left to set a reminder and assign a due date'),
    Task(name: 'Press and hold the Share button to share the task as a PDF'),
  ];

  TaskData() {
    _loadTasks();
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(Task task) async {
    _tasks.add(task);
    await _saveTasks();
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void updateTask(Task task) async {
    task.toggleDone();
    await _saveTasks();
    notifyListeners();
  }

  Future<void> saveTask(Task task) async {
    if (!_tasks.contains(task)) {
      return;
    }
    await _saveTasks();
    notifyListeners();
  }

  void deleteTask(Task task) async {
    _tasks.remove(task);
    await _saveTasks();
    notifyListeners();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList('tasks');
    if (taskList != null) {
      _tasks = taskList.map((task) => Task.fromMap(task)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = _tasks.map((task) => jsonEncode(task.toMap())).toList();
    prefs.setStringList('tasks', taskList);
  }

  void deleteAllTasks() async {
    _tasks.clear();
    await _saveTasks();
    notifyListeners();
  }
}
