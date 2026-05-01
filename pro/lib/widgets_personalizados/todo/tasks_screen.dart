import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../constantes/export_constantes.dart';
import 'add_task_screen.dart';
import 'export_options.dart';
import 'tasks_list.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    //comenzando con las notificaciones push locales

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kColorBotones,
                ),
                child: const Icon(
                  Icons.list_rounded,
                  size: 100,
                  color: kColorBlanco,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.todoList,
                style: kTextoBotones,
              ),
              Text(
                '${Provider.of<TaskData>(context).taskCount} ${AppLocalizations.of(context)!.tareas}',
                style: kEstiloSubMenu,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Animate(
                      effects: const [
                        MoveEffect(
                          curve: Curves.bounceIn,
                          duration: Duration(milliseconds: 100),
                        ),
                        ShakeEffect(
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 100),
                        ),
                        ScaleEffect(
                          duration: Duration(milliseconds: 10),
                        ),
                      ],
                      child: Row(
                        children: [
                          //Share
                          GestureDetector(
                            onLongPress: () async {
                              // Asegúrate de que onLongPress sea async
                              final tasks =
                                  Provider.of<TaskData>(context, listen: false)
                                      .tasks;

                              // Muestra el diálogo de opciones de exportación
                              ExportOptions? options =
                                  await showDialog<ExportOptions>(
                                context: context,
                                builder: (BuildContext context) {
                                  return const ExportOptionsDialog();
                                },
                              );

                              // Si el usuario seleccionó opciones y presionó "Aceptar", genera el PDF y lo guarda
                              if (options != null) {
                                await generatePdfAndSave(
                                    tasks, context, options);
                              }
                            },
                            child: FloatingActionButton.extended(
                              extendedTextStyle:
                                  const TextStyle(color: Colors.white),
                              backgroundColor: kColorBotones,
                              elevation: 9,
                              onPressed: () async {
                                final tasks = Provider.of<TaskData>(context,
                                        listen: false)
                                    .tasks;

                                // Muestra el diálogo de opciones de exportación
                                ExportOptions? options =
                                    await showDialog<ExportOptions>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ExportOptionsDialog();
                                  },
                                );

                                // Si el usuario seleccionó opciones y presionó "Aceptar", genera el texto de todas las tareas con las opciones seleccionadas
                                if (options != null) {
                                  String allTasksText = tasks.map((task) {
                                    String taskText = task.name;
                                    if (options.includeTaskStatus) {
                                      taskText +=
                                          ' - ${task.isDone ? AppLocalizations.of(context)!.completada : AppLocalizations.of(context)!.noCompletada}';
                                    }
                                    if (options.includeReminderDate) {
                                      taskText +=
                                          ' - ${AppLocalizations.of(context)!.fechaRecordatorio}: ${task.reminderDateTime != null ? DateFormat('yyyy-MM-dd – kk:mm').format(task.reminderDateTime!) : AppLocalizations.of(context)!.noAsignado}';
                                    }
                                    if (options.includeDueDate) {
                                      taskText +=
                                          ' - ${AppLocalizations.of(context)!.fechaEntrega}: ${task.dueDate != null ? DateFormat('yyyy-MM-dd – kk:mm').format(task.dueDate!) : AppLocalizations.of(context)!.noAsignado}';
                                    }
                                    return taskText;
                                  }).join('\n');

                                  // Comparte el texto de todas las tareas
                                  Share.share(allTasksText);
                                }
                              },
                              label: Text(
                                AppLocalizations.of(context)!.compartirTareas,
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Poppins'),
                              ),
                              icon: const Icon(
                                Icons.share,
                                color: Colors
                                    .white, //Share Icon color changed to white to ensure contrast
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          //Add
                          GestureDetector(
                            onLongPress: () {
                              int taskCount =
                                  Provider.of<TaskData>(context, listen: false)
                                      .taskCount;
                              if (taskCount > 0) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: kColorBotones,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .eliminarTodasLasTareas,
                                      style: kTextoBotones,
                                    ),
                                    content: Text(
                                      AppLocalizations.of(context)!
                                          .confirmacionEliminarTareas,
                                      style: kTexto,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .cancelar,
                                          style: kTextoBotones2,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Provider.of<TaskData>(context,
                                                  listen: false)
                                              .deleteAllTasks();
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .eliminar,
                                          style: kTextoCerrar,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: FloatingActionButton.extended(
                              backgroundColor: kColorBotones,
                              elevation: 9,
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: const AddTaskScreen(),
                                    ),
                                  ),
                                );
                              },
                              label: Text(
                                AppLocalizations.of(context)!.agregar,
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          (isMobile ? .08 : .07),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 20,
                    bottom: 20,
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
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const TasksList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> generatePdfAndSave(List<Task> tasks, BuildContext flutterContext,
      ExportOptions options) async {
    final pdf = pw.Document();

    // Cargar la imagen
    final Uint8List imageData = await readImageData(
        'assets/images/icono_app_nuevo.png'); // Necesitas reemplazar 'ruta_a_la_imagen' con la ruta actual a tu imagen
    final imageProvider = pw.MemoryImage(imageData);

    // Obtener la localización aquí antes de iniciar la operación asíncrona
    final appLocalization = AppLocalizations.of(flutterContext);

    pdf.addPage(
      pw.Page(
        build: (pw.Context pdfContext) => pw.Column(
          children: [
            pw.Image(imageProvider,
                width: 80,
                height: 80,
                fit: pw.BoxFit.scaleDown), // Imagen ajustada
            pw.Text(appLocalization!.formulaePro), // Texto adicional
            pw.SizedBox(height: 10),
            ...tasks.map((task) {
              String taskText = task.name;
              if (options.includeTaskStatus) {
                taskText += ' - ${task.isDone ? '[x]' : '[ ]'}';
              }
              if (options.includeReminderDate) {
                taskText +=
                    ' - ${AppLocalizations.of(flutterContext)!.fechaRecordatorio}: ${task.reminderDateTime != null ? DateFormat('yyyy-MM-dd – kk:mm').format(task.reminderDateTime!) : AppLocalizations.of(flutterContext)!.noAsignado}';
              }
              if (options.includeDueDate) {
                taskText +=
                    ' - ${AppLocalizations.of(flutterContext)!.fechaEntrega}: ${task.dueDate != null ? DateFormat('yyyy-MM-dd – kk:mm').format(task.dueDate!) : AppLocalizations.of(flutterContext)!.noAsignado}';
              }
              return pw.Text(taskText);
            }), // Un espacio entre el texto y las tareas
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = io.File("${output.path}/${appLocalization!.tareasPDF}");
    await file.writeAsBytes(await pdf.save());

    // comparte el archivoX
    Share.shareXFiles(
      [XFile('${output.path}/${appLocalization.tareasPDF}')],
      subject: appLocalization.tarea,
    );
  }

// Función para leer la imagen como un Uint8List
  Future<Uint8List> readImageData(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
