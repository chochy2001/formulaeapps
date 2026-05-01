import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constantes/export_constantes.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final void Function(bool?)? checkboxCallback;
  final Function longPressCallback;

  const TaskTile({
    Key? key,
    required this.isChecked,
    required this.taskTitle,
    required this.checkboxCallback,
    required this.longPressCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //todo checar que onda con el longPress
      onLongPress: () {
        longPressCallback();
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
