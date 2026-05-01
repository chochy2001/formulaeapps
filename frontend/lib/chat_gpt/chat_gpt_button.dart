import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Favorites/pdf_capture_scope.dart';
import '../constantes/constantes_codigo.dart';
import 'chat_screen.dart';

class ChatGPTButton extends StatelessWidget {
  final Widget child;

  const ChatGPTButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (PdfCaptureScope.of(context)) {
      return child;
    }

    if (kIsWeb || Platform.isWindows || Platform.isLinux) {
      return child;
    } else {
      return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: MediaQuery.of(context).size.width * 0.05,
        children: [
          child,
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: kColorBotones,
                    elevation: .5,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .5,
                      child: const ChatScreen(),
                    ),
                  );
                },
              );
            },
            child: Image.asset(
              'assets/images/chatgpt.png',
              width: MediaQuery.of(context).size.width * 0.11,
              height: MediaQuery.of(context).size.height * 0.11,
            ),
          ),
        ],
      );
    }
  }
}
