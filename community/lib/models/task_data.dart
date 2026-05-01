import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Mantén presionado para eliminar la tarea'),
    Task(name: 'Mantén presionado el botón + para eliminar todas las tareas'),
    Task(name: 'Tarea demo'),
  ];

  TaskData() {
    _loadTasks();
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) async {
    final task = Task(name: newTaskTitle);
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
