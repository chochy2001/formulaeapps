import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/main.dart';
import 'package:formulae/models/task_data.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/widgets_personalizados/boton_pistas.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('MyApp restart is available after initState', (tester) async {
    final favorites = FavoritesNotifier();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<LocaleProvider>(
            create: (_) => LocaleProvider(const Locale('es')),
          ),
          ChangeNotifierProvider<ModelsProvider>(
            create: (_) => ModelsProvider(),
          ),
          ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
          ChangeNotifierProvider<TaskData>(create: (_) => TaskData()),
          ChangeNotifierProvider<FavoritesNotifier>.value(value: favorites),
        ],
        child: MyApp(favoritesNotifier: favorites),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);

    final materialApp = find.byType(MaterialApp);
    expect(materialApp, findsOneWidget);
    final appBeforeRestart = tester.widget<MaterialApp>(materialApp);
    expect(appBeforeRestart.title, 'Formulae Community');
    final keyBefore = appBeforeRestart.key;

    MyApp.restartApp();
    await tester.pump();
    expect(tester.takeException(), isNull);

    final keyAfter = tester.widget<MaterialApp>(materialApp).key;
    expect(keyAfter, isNot(equals(keyBefore)));
  });

  testWidgets('VerPistas keeps its scrollable constrained layout', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(400, 800));
    await tester.pumpWidget(
      const MaterialApp(home: VerPistas(Text('Pista de prueba'))),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Pista de prueba'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.child is ListView,
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
  });
}
