import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../Favorites/favorite_pdf_downloader.dart';
import '../../constantes/export_constantes.dart';
import 'add_task_screen.dart';
import 'export_options.dart';
import 'tasks_list.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  alignment: WrapAlignment.end,
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
                        ScaleEffect(duration: Duration(milliseconds: 10)),
                      ],
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: MediaQuery.of(context).size.width * .02,
                        runSpacing: 8,
                        children: [
                          //Share
                          GestureDetector(
                            onLongPress: () =>
                                _showExportOptionsAndExport(context),
                            child: FloatingActionButton.extended(
                              extendedTextStyle: const TextStyle(
                                color: kColorTextoSobreAcento,
                              ),
                              // Accion SECUNDARIA (compartir): acento teal.
                              backgroundColor: kColorAcentoSecundario,
                              elevation: 9,
                              onPressed: () async {
                                final tasks = Provider.of<TaskData>(
                                  context,
                                  listen: false,
                                ).tasks;

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
                                  String allTasksText = tasks
                                      .map((task) {
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
                                      })
                                      .join('\n');

                                  // Comparte el texto de todas las tareas
                                  SharePlus.instance.share(
                                    ShareParams(text: allTasksText),
                                  );
                                }
                              },
                              label: Text(
                                AppLocalizations.of(context)!.compartirTareas,
                                style: const TextStyle(
                                  color: kColorTextoSobreAcento,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              icon: const Icon(
                                Icons.share,
                                // Texto oscuro sobre el teal para asegurar
                                // contraste (6.56:1).
                                color: kColorTextoSobreAcento,
                              ),
                            ),
                          ),
                          //Add
                          GestureDetector(
                            onLongPress: () {
                              int taskCount = Provider.of<TaskData>(
                                context,
                                listen: false,
                              ).taskCount;
                              if (taskCount > 0) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: kColorBotones,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.eliminarTodasLasTareas,
                                      style: kTextoBotones,
                                    ),
                                    content: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.confirmacionEliminarTareas,
                                      style: kTexto,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.cancelar,
                                          style: kTextoBotones2,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Provider.of<TaskData>(
                                            context,
                                            listen: false,
                                          ).deleteAllTasks();
                                        },
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.eliminar,
                                          style: kTextoCerrar,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: FloatingActionButton.extended(
                              // Accion PRIMARIA (agregar tarea): acento dorado.
                              backgroundColor: kColorAcentoPrimario,
                              elevation: 9,
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                      ),
                                      child: const AddTaskScreen(),
                                    ),
                                  ),
                                );
                              },
                              label: Text(
                                AppLocalizations.of(context)!.agregar,
                                style: const TextStyle(
                                  color: kColorTextoSobreAcento,
                                ),
                              ),
                              icon: const Icon(
                                Icons.add,
                                // Texto oscuro sobre el dorado (7.14:1).
                                color: kColorTextoSobreAcento,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Future<void> _showExportOptionsAndExport(BuildContext context) async {
    final tasks = Provider.of<TaskData>(context, listen: false).tasks;
    final options = await showDialog<ExportOptions>(
      context: context,
      builder: (context) => const ExportOptionsDialog(),
    );

    if (options == null || !context.mounted) {
      return;
    }

    final localizations = AppLocalizations.of(context)!;
    try {
      await generatePdfAndSave(tasks, context, options);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(localizations.pdfGenerado)));
    } catch (error, stackTrace) {
      debugPrint('Formulae tasks PDF export failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(localizations.mensajeError)));
    }
  }

  Future<void> generatePdfAndSave(
    List<Task> tasks,
    BuildContext flutterContext,
    ExportOptions options,
  ) async {
    if (!flutterContext.mounted) {
      return;
    }

    final appLocalization = AppLocalizations.of(flutterContext)!;
    final pdfBytes = await buildTasksPdfBytes(
      tasks: tasks,
      options: options,
      localizations: appLocalization,
    );

    if (!flutterContext.mounted) {
      return;
    }
    await downloadFavoritePdf(pdfBytes, appLocalization.tareasPDF);
  }

  @visibleForTesting
  static Future<pw.Document> buildTasksPdfDocument({
    required List<Task> tasks,
    required ExportOptions options,
    required AppLocalizations localizations,
  }) async {
    final pdf = pw.Document();
    final imageData = await readImageData('assets/images/icono_app_nuevo.png');
    final imageProvider = pw.MemoryImage(imageData);
    final textFont = pw.Font.ttf(
      await rootBundle.load('fonts/Poppins-Bold.ttf'),
    );
    final mathFont = pw.Font.ttf(
      await rootBundle.load('fonts/NotoSansMath-Regular.ttf'),
    );

    // Una página única recortaba las listas largas. MultiPage conserva todas
    // las tareas y distribuye los renglones entre páginas A4 cuando es necesario.
    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: textFont,
          bold: textFont,
          italic: textFont,
          boldItalic: textFont,
          fontFallback: [mathFont],
        ),
        build: (_) => [
          pw.Center(
            child: pw.Image(
              imageProvider,
              width: 80,
              height: 80,
              fit: pw.BoxFit.scaleDown,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Center(child: pw.Text(localizations.formulaePro)),
          pw.SizedBox(height: 10),
          ...tasks.map(
            (task) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 4),
              child: pw.Text(_formatTaskForPdf(task, options, localizations)),
            ),
          ),
        ],
      ),
    );

    return pdf;
  }

  @visibleForTesting
  static Future<Uint8List> buildTasksPdfBytes({
    required List<Task> tasks,
    required ExportOptions options,
    required AppLocalizations localizations,
  }) async {
    final pdf = await buildTasksPdfDocument(
      tasks: tasks,
      options: options,
      localizations: localizations,
    );
    return pdf.save();
  }

  static String _formatTaskForPdf(
    Task task,
    ExportOptions options,
    AppLocalizations localizations,
  ) {
    var taskText = task.name;
    if (options.includeTaskStatus) {
      taskText += ' - ${task.isDone ? '[x]' : '[ ]'}';
    }
    if (options.includeReminderDate) {
      taskText +=
          ' - ${localizations.fechaRecordatorio}: ${task.reminderDateTime != null ? DateFormat('yyyy-MM-dd – kk:mm').format(task.reminderDateTime!) : localizations.noAsignado}';
    }
    if (options.includeDueDate) {
      taskText +=
          ' - ${localizations.fechaEntrega}: ${task.dueDate != null ? DateFormat('yyyy-MM-dd – kk:mm').format(task.dueDate!) : localizations.noAsignado}';
    }
    return taskText;
  }

  static Future<Uint8List> readImageData(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
