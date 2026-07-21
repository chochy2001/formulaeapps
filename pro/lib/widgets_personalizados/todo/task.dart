import 'dart:convert';

class Task {
  final String name;
  bool isDone;
  DateTime?
  reminderDateTime; // Campo para almacenar la fecha y hora del recordatorio
  DateTime?
  dueDate; // Nuevo campo para almacenar la fecha de vencimiento de la tarea

  Task({
    required this.name,
    this.isDone = false,
    this.reminderDateTime,
    this.dueDate,
  });

  void toggleDone() {
    isDone = !isDone;
  }

  // Método para convertir una tarea en un mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isDone': isDone,
      'reminderDateTime': reminderDateTime?.toIso8601String(),
      'dueDate': dueDate
          ?.toIso8601String(), // Convertir la fecha a un string en formato ISO 8601
    };
  }

  // Método para crear una tarea desde un mapa
  static Task fromMap(String json) {
    final map = jsonDecode(json);
    return Task(
      name: map['name'],
      isDone: map['isDone'],
      reminderDateTime: map['reminderDateTime'] != null
          ? DateTime.parse(map['reminderDateTime'])
          : null,
      dueDate: map['dueDate'] != null
          ? DateTime.parse(map['dueDate'])
          : null, // Convertir el string a un objeto DateTime
    );
  }
}
