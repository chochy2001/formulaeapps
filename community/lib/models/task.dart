import 'dart:convert';

class Task {
  final String name;
  bool isDone;

  Task({required this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  // Método para convertir una tarea en un mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isDone': isDone,
    };
  }

  // Método para crear una tarea desde un mapa
  static Task fromMap(String json) {
    final map = jsonDecode(json);
    return Task(
      name: map['name'],
      isDone: map['isDone'],
    );
  }
}
