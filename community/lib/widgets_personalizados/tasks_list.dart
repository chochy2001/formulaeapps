import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../models/task_data.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return taskData.taskCount == 0
            ? ImagenRemotaRobusta(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                urlImagen: kUrlImagenAgregarTarea,
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  final task = taskData.tasks[index];
                  return TaskTile(
                    taskTitle: task.name,
                    isChecked: task.isDone,
                    checkboxCallback: (bool? checkboxState) {
                      taskData.updateTask(task);
                    },
                    longPressCallback: () {
                      taskData.deleteTask(task);
                    },
                  );
                },
                itemCount: taskData.taskCount,
              );
      },
    );
  }
}
