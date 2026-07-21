import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

import '../../../widgets_personalizados/export_widgets_personalizados.dart';
import '../screens/tasks_screen.dart';

class TodoListIntermedio extends StatelessWidget {
  const TodoListIntermedio({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const ScaffoldScreen(
        appBar: AppBarHome(visible: false),
        drawer: DrawerPersonalizado(0),
        body: TasksScreen(),
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      return const ScaffoldScreen(
        appBar: AppBarHome(visible: false),
        drawer: DrawerPersonalizado(1),
        body: TasksScreen(),
      );
    } else {
      //Se puso un else, ya que si no es ni android ni IOS entrará ahí y se quita el warning
      return const ScaffoldScreen(
        appBar: AppBarHome(visible: false),
        drawer: DrawerPersonalizado(2),
        body: TasksScreen(),
      );
    }
  }
}
