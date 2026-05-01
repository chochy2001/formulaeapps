import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../models/task_data.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return taskData.taskCount == 0
            ? FadeInImage(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                placeholder: const AssetImage(kUrlImagenGifCarga),
                image: const NetworkImage(kUrlImagenAgregarTarea),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  final task = taskData.tasks[index];
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        TaskTile(
                          taskTitle: task.name,
                          isChecked: task.isDone,
                          checkboxCallback: (bool? checkboxState) {
                            taskData.updateTask(task);
                          },
                          longPressCallback: () {
                            taskData.deleteTask(task);
                          },
                        ),
                      ],
                    ),
                  );
                },
                itemCount: taskData.taskCount,
              );
      },
    );
  }
}
