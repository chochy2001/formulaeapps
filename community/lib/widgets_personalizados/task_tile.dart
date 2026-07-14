import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constantes/export_constantes.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final void Function(bool?)? checkboxCallback;
  final Function longPressCallback;

  const TaskTile({
    super.key,
    required this.isChecked,
    required this.taskTitle,
    required this.checkboxCallback,
    required this.longPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: kColorBotones,
              title: const Center(
                child: Text(
                  'Eliminar tarea',
                  style: kTextoBotones,
                ),
              ),
              content: const Text(
                '¿Está seguro que desea eliminar la tarea?',
                style: kTexto,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancelar',
                    style: kTextoBotones2,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    longPressCallback();
                  },
                  child: const Text(
                    'Eliminar',
                    style: kTextoCerrar,
                  ),
                ),
              ],
            );
          },
        );
      },
      title: Text(
        taskTitle,
        style: GoogleFonts.roboto(
          decoration: isChecked ? TextDecoration.lineThrough : null,
          color: kColorBlanco,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: Checkbox(
        checkColor: kColorBlanco,
        side: const BorderSide(
          width: 2,
          color: kColorBlanco,
        ),
        activeColor: kColorBotones,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
