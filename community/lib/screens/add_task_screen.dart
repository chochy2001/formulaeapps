import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constantes/constantes_codigo.dart';
import '../models/task_data.dart';

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
            color: Colors.black.withValues(alpha: 0.5),
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
          const Text(
            "Nueva Tarea",
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
                    color: Colors.black.withValues(alpha: 0.5),
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
              child: const Center(
                child: Text(
                  "Añadir",
                  style: TextStyle(
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

  void _addTask(BuildContext context, String newTaskTitle) {
    if (newTaskTitle.isNotEmpty) {
      Provider.of<TaskData>(context, listen: false).addTask(newTaskTitle);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
