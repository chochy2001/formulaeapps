import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';

import '../../../constantes/export_constantes.dart';
import '../models/task_data.dart';
import '../screens/add_task_screen.dart';

class TasksScreen extends StatefulWidget {

  static const int maxFailedLoadAttempts = 3;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  void initState() {
    super.initState();
    _ads.start(onBannerReady: () { if (mounted) setState(() {}); });
  }


  Widget get adContainer => _ads.banner;

  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

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
                                    AppLocalizations.of(context)!.cancelar,
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
                                    AppLocalizations.of(context)!.eliminar,
                                    style: kTextoCerrar,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Animate(
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
                        child: FloatingActionButton.extended(
                          extendedTextStyle:
                              const TextStyle(color: Colors.white),
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
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Poppins"),
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
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
}
