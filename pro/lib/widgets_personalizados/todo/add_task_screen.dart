import 'package:flutter/material.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constantes/export_constantes.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  AddTaskScreenState createState() => AddTaskScreenState();
}

class AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * .1,
        right: MediaQuery.of(context).size.width * .1,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: kColorBotones,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Text(
            AppLocalizations.of(context)!.nuevaTarea,
            style: kTextoBotones,
          ),
          TextField(
            controller: _taskController,
            autofocus: true,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: kColorBlanco,
              fontSize: 20,
            ),
            onSubmitted: (newTaskTitle) {
              _addTask(context, newTaskTitle);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          ),
          TextButton(
            onPressed: () {
              _addTask(context, _taskController.text);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * .07,
              width: MediaQuery.of(context).size.width * 2,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: kColorFondo,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.agregar,
                  style: const TextStyle(
                    color: kColorBlanco,
                    backgroundColor: kColorFondo,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addTask(BuildContext context, String newTaskTitle) async {
    if (newTaskTitle.isNotEmpty) {
      // Permitir al usuario seleccionar una fecha de recordatorio
      DateTime? reminderDateTime = await showDateTimeDialog(
          context, AppLocalizations.of(context)!.fechaRecordatorio);
      if (!context.mounted) return;
      // Permitir al usuario seleccionar una fecha de vencimiento
      DateTime? dueDate = await showDateTimeDialog(
          context, AppLocalizations.of(context)!.fechaEntrega);
      if (!context.mounted) return;
      // Crear una nueva tarea con las fechas seleccionadas
      Task newTask = Task(
        name: newTaskTitle,
        reminderDateTime: reminderDateTime,
        dueDate: dueDate,
      );
      // Agregar la nueva tarea a la lista de tareas
      Provider.of<TaskData>(context, listen: false).addTask(newTask);
      Navigator.pop(context);
    }
  }

  Future<DateTime?> showDateTimeDialog(
      BuildContext context, String dialogTitle) async {
    DateTime? picked;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: kColorBotones,
          title: Text(dialogTitle, style: kTextoBotones),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                child: Text(AppLocalizations.of(context)!.saltar),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text(AppLocalizations.of(context)!.seleccionarFecha),
                onPressed: () async {
                  picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    if (!context.mounted) return;
                    final TimeOfDay? timePicked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (timePicked != null) {
                      picked = DateTime(picked!.year, picked!.month,
                          picked!.day, timePicked.hour, timePicked.minute);
                    }
                  }
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
    return picked;
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
