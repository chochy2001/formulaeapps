import 'package:flutter/material.dart';

import '../chat_gpt/export_chat_gpt.dart';
import '../constantes/export_constantes.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: kColorFondo,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextWidget(
                  label: AppLocalizations.of(context)!.escogeModelo,
                  fontSize: 20,
                  color: kColorBlanco,
                ),
              ),
              const Flexible(flex: 2, child: ModelsDropDownWidget()),
            ],
          ),
        );
      },
    );
  }
}
