import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../constantes/export_constantes.dart';
import '../../../../widgets_personalizados/export_widgets_personalizados.dart';
import '../../main.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void shareTask(Task task, BuildContext context) {
      String taskName = AppLocalizations.of(context)!.tarea;
      String status = task.isDone
          ? AppLocalizations.of(context)!.completada
          : AppLocalizations.of(context)!.noCompletada;

      String shareText =
          '$taskName: ${task.name}, ${AppLocalizations.of(context)!.estado}: $status';

      Share.share(shareText);
    }

    Future<DateTime?> showDateTimeDialog(
        BuildContext context, Task task) async {
      return showDialog<DateTime>(
        context: context,
        builder: (context) {
          DateTime? selectedDateTime;
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: kColorBotones,
            title: Text(
              AppLocalizations.of(context)!.asignarRecordatorio,
              style: kTexto,
            ),
            content: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: kColorBotones,
                  // Cambia el color del texto aquí
                  surface: kColorBlanco,
                  onSurface: kColorBotones,
                  onPrimary: kColorBlanco,
                  onError: Colors.red,
                ),
              ),
              child: DateTimeField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hoverColor: kColorBotones,
                  iconColor: kColorBotones,
                  floatingLabelStyle: kTexto,
                  suffixIconColor: kColorBlanco,
                  prefixIconColor: kColorBlanco,
                  filled: true,
                  fillColor: kColorBotones,
                  labelText: AppLocalizations.of(context)!.fechaRecordatorio,
                  labelStyle: kTexto,
                  hintStyle: kTexto,
                  focusColor: kColorBotones,
                ),
                format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                    context: context, // Pasar directamente el BuildContext
                    firstDate: DateTime.now(),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    selectedDateTime = DateTimeField.combine(date, time);
                    return selectedDateTime;
                  } else {
                    return currentValue;
                  }
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.cancelar,
                  style: kTextoCerrar,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.guardarRecordatorio,
                  style: kTexto,
                ),
                onPressed: () async {
                  //aqui poner la logica de asignacion para el recordatorio
                  // Aquí puedes llamar a la lógica para establecer el recordatorio.
                  var scheduledNotificationDateTime =
                      selectedDateTime; // La fecha y hora seleccionadas por el usuario.
                  task.reminderDateTime =
                      selectedDateTime; //todo darle un buen formato a la hora de imprimirla
                  if (scheduledNotificationDateTime!.isAfter(DateTime.now())) {
                    var androidPlatformChannelSpecifics =
                        const AndroidNotificationDetails(
                            'your_other_channel_id', 'your_other_channel_name',
                            importance: Importance
                                .high, // puedes cambiar esto según tus necesidades
                            priority: Priority
                                .high, // puedes cambiar esto según tus necesidades
                            showWhen: false,
                            channelDescription:
                                'your_other_channel_description' // Asegúrate de agregar una descripción aquí
                            );
                    var iOSPlatformChannelSpecifics =
                        const DarwinNotificationDetails(
                      presentAlert: true,
                      presentBadge: true,
                      presentSound: true,
                    );
                    var macOSPlatformChannelSpecifics =
                        const DarwinNotificationDetails(
                      presentAlert: true,
                      presentBadge: true,
                      presentSound: true,
                    );
                    //todo hacer que funcione en macOS con las notificaciones
                    var platformChannelSpecifics = NotificationDetails(
                      android: androidPlatformChannelSpecifics,
                      iOS: iOSPlatformChannelSpecifics,
                      macOS: macOSPlatformChannelSpecifics,
                    );
                    await flutterLocalNotificationsPlugin.zonedSchedule(
                      0,
                      AppLocalizations.of(context)!.formulaePro,
                      "${AppLocalizations.of(context)!.hacerTarea} ${task.name}", // El cuerpo de la notificación
                      tz.TZDateTime.from(
                          scheduledNotificationDateTime, tz.local),
                      platformChannelSpecifics,
                      uiLocalNotificationDateInterpretation:
                          UILocalNotificationDateInterpretation.absoluteTime,
                      androidScheduleMode: AndroidScheduleMode.exact,
                    );
                  } else {
                    // Mostrar un mensaje al usuario indicando que la fecha y hora seleccionadas deben estar en el futuro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.fechaFuturo,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        void editTask(Task task, BuildContext context) async {
          TextEditingController taskNameController =
              TextEditingController(text: task.name);
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: kColorBotones,
                title: Text(
                  AppLocalizations.of(context)!.editarTarea,
                  style: kTextoBotones,
                ),
                content: TextField(
                  style: const TextStyle(color: kColorBlanco),
                  controller: taskNameController,
                  decoration: InputDecoration(
                    fillColor: kColorBlanco,
                    labelText: AppLocalizations.of(context)!.nombreTarea,
                    labelStyle: kTexto,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppLocalizations.of(context)!.cancelar,
                      style: kTextoCerrar,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Obtén la instancia de TaskData del Provider
                      TaskData taskData =
                          Provider.of<TaskData>(context, listen: false);
                      taskData.deleteTask(task);
                      // Crea una nueva tarea con el nombre editado y las fechas existentes
                      Task newTask = Task(
                        name: taskNameController.text,
                        reminderDateTime: task.reminderDateTime,
                        dueDate: task.dueDate,
                      );
                      taskData.addTask(newTask);
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.guardar,
                      style: kTexto,
                    ),
                  ),
                ],
              );
            },
          );
        }

        return taskData.taskCount == 0
            ? FadeInImage(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                placeholder: const AssetImage(kUrlImagenGifCarga),
                image: NetworkImage(
                    getImageUrlById(context, kImagenAgregarTarea) ??
                        kUrlImagenAgregarTarea),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  final task = taskData.tasks[index];
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Slidable(
                          startActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),
                            // All actions are defined in the children parameter.
                            children: [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        backgroundColor: kColorBotones,
                                        title: Center(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .eliminarTarea,
                                            style: kTextoBotones,
                                          ),
                                        ),
                                        content: Text(
                                          AppLocalizations.of(context)!
                                              .confirmacionEliminarTarea,
                                          style: kTexto,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .cancelar,
                                              style: kTextoBotones2,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              taskData.deleteTask(task);
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .eliminar,
                                              style: kTextoCerrar,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                backgroundColor: kColorBotones,
                                foregroundColor: Colors.red,
                                icon: Icons.delete,
                                label: AppLocalizations.of(context)!.eliminar,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  shareTask(task, context);
                                },
                                backgroundColor: kColorBotones,
                                foregroundColor: Colors.white,
                                icon: Icons.share,
                                label: AppLocalizations.of(context)!.compartir,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  editTask(task, context);
                                },
                                backgroundColor: kColorBotones,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: AppLocalizations.of(context)!.editar,
                              ),
                            ],
                          ),

                          // The end action pane is the one at the right or the bottom side.
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 2,
                                onPressed: (context) async {
                                  DateTime? selectedDateTime =
                                      await showDateTimeDialog(context, task);
                                  if (selectedDateTime != null) {
                                    // Guarda la fecha y hora seleccionadas en la tarea correspondiente
                                    task.reminderDateTime = selectedDateTime;

                                    // Programa la notificación
                                    const AndroidNotificationDetails
                                        androidPlatformChannelSpecifics =
                                        AndroidNotificationDetails(
                                            'your channel id',
                                            'your channel name',
                                            importance: Importance.max,
                                            priority: Priority.high,
                                            showWhen: false);

                                    const NotificationDetails
                                        platformChannelSpecifics =
                                        NotificationDetails(
                                            android:
                                                androidPlatformChannelSpecifics);

                                    await flutterLocalNotificationsPlugin
                                        .zonedSchedule(
                                      0,
                                      'Recordatorio de tarea',
                                      task.name,
                                      tz.TZDateTime.from(
                                          selectedDateTime, tz.local),
                                      platformChannelSpecifics,
                                      uiLocalNotificationDateInterpretation:
                                          UILocalNotificationDateInterpretation
                                              .absoluteTime,
                                      matchDateTimeComponents:
                                          DateTimeComponents.dayOfWeekAndTime,
                                    );
                                  }
                                },
                                backgroundColor: kColorBotones,
                                foregroundColor: kColorAmarilloCapdesis,
                                icon: Icons.add_alert,
                                label:
                                    AppLocalizations.of(context)!.recordatorio,
                              ),
                              SlidableAction(
                                onPressed: (context) async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: task.dueDate ?? DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );

                                  if (selectedDate != null) {
                                    task.dueDate =
                                        selectedDate; // Asignar la fecha seleccionada a la fecha de vencimiento de la tarea
                                  }
                                },
                                backgroundColor: kColorBotones,
                                foregroundColor: Colors.white,
                                icon: Icons.calendar_month_outlined,
                                label: AppLocalizations.of(context)!.plazo,
                              ),
                            ],
                          ),

                          // The child of the Slidable is what the user sees when the
                          // component is not dragged.
                          child: TaskTile(
                            taskTitle: task.name,
                            isChecked: task.isDone,
                            checkboxCallback: (bool? checkboxState) {
                              taskData.updateTask(task);
                            },
                            longPressCallback: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: kColorBotones,
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .detallesTarea,
                                      style: kEstiloBotones,
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            '${AppLocalizations.of(context)!.tarea}: ${task.name}',
                                            style: kTexto,
                                          ),
                                          Text(
                                            '${AppLocalizations.of(context)!.estado}: ${task.isDone ? AppLocalizations.of(context)!.completada : AppLocalizations.of(context)!.noCompletada}',
                                            style: kTexto,
                                          ),
                                          Text(
                                            "${AppLocalizations.of(context)!.fechaRecordatorio}: ${task.reminderDateTime != null ? DateFormat('yyyy-MM-dd – kk:mm').format(task.reminderDateTime!) : AppLocalizations.of(context)!.noAsignado}",
                                            style: kTexto,
                                          ),
                                          Text(
                                            "${AppLocalizations.of(context)!.fechaEntrega}: ${task.dueDate != null ? DateFormat('yyyy-MM-dd').format(task.dueDate!) : AppLocalizations.of(context)!.noAsignado}",
                                            style: kTexto,
                                          ),
                                          // Agrega aquí más propiedades de la tarea si las hay
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          AppLocalizations.of(context)!.cerrar,
                                          style: kTextoCerrar,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
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
