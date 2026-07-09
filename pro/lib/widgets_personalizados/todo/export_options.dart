import 'package:flutter/material.dart';

import '../../constantes/export_constantes.dart';

class ExportOptionsDialog extends StatefulWidget {
  const ExportOptionsDialog({super.key});

  @override
  ExportOptionsDialogState createState() => ExportOptionsDialogState();
}

class ExportOptionsDialogState extends State<ExportOptionsDialog> {
  bool includeDueDate = false;
  bool includeReminderDate = false;
  bool includeTaskStatus = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kColorBotones,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        AppLocalizations.of(context)!.opcionesExportacion,
        style: kTexto,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CheckboxListTile(
            title: Text(
              AppLocalizations.of(context)!.incluirFechaEntrega,
              style: kTexto,
            ),
            value: includeDueDate,
            onChanged: (bool? value) {
              setState(() {
                includeDueDate = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              AppLocalizations.of(context)!.incluirRecordatorio,
              style: kTexto,
            ),
            value: includeReminderDate,
            onChanged: (bool? value) {
              setState(() {
                includeReminderDate = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              AppLocalizations.of(context)!.incluirEstado,
              style: kTexto,
            ),
            value: includeTaskStatus,
            onChanged: (bool? value) {
              setState(() {
                includeTaskStatus = value!;
              });
            },
          ),
        ],
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
            AppLocalizations.of(context)!.aceptar,
            style: kTexto,
          ),
          onPressed: () {
            Navigator.of(context).pop(ExportOptions(
              includeDueDate: includeDueDate,
              includeReminderDate: includeReminderDate,
              includeTaskStatus: includeTaskStatus,
            ));
          },
        ),
      ],
    );
  }
}

class ExportOptions {
  bool includeDueDate;
  bool includeReminderDate;
  bool includeTaskStatus;

  ExportOptions({
    required this.includeDueDate,
    required this.includeReminderDate,
    required this.includeTaskStatus,
  });
}
