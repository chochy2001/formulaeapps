import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

import '../../../widgets_personalizados/export_widgets_personalizados.dart';
import '../../chat_gpt/chat_screen.dart';

class ChatGPTIntermedio extends StatelessWidget {
  const ChatGPTIntermedio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const ScaffoldScreen(
        appBar: AppBarHome(
          visible: false,
        ),
        drawer: DrawerPersonalizado(0),
        body: ChatScreen(),
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      return const ScaffoldScreen(
        appBar: AppBarHome(
          visible: false,
        ),
        drawer: DrawerPersonalizado(1),
        body: ChatScreen(),
      );
    } else {
      return const ScaffoldScreen(
        appBar: AppBarHome(
          visible: false,
        ),
        drawer: DrawerPersonalizado(2),
        body: ChatScreen(),
      );
      //Se puso un else, ya que si no es ni android ni IOS entrará ahí y se quita el warning
    }
  }
}
