import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/constantes/constantes_mapa_videos.dart';
import 'package:formulae/constantes/nombres_videos.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/menus/menu.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/widgets_personalizados/todo/add_task_screen.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'adding a task after skipping optional dates saves it and closes the sheet',
    (tester) async {
      final taskData = TaskData();

      await tester.pumpWidget(
        _app(
          taskData: taskData,
          child: const Scaffold(body: AddTaskScreen()),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Preparar examen');
      await tester.tap(find.text('Agregar'));
      await tester.pumpAndSettle();
      expect(find.text('Fecha Recordatorio'), findsOneWidget);

      await tester.tap(find.text('Saltar'));
      await tester.pumpAndSettle();
      expect(find.text('Fecha Entrega'), findsOneWidget);

      await tester.tap(find.text('Saltar'));
      await tester.pumpAndSettle();
      expect(
        taskData.tasks.map((task) => task.name),
        contains('Preparar examen'),
      );
      expect(find.byType(AddTaskScreen), findsNothing);
    },
  );

  testWidgets(
    'video URLs follow the selected locale and leave unavailable translations absent',
    (tester) async {
      late BuildContext spanishContext;
      await tester.pumpWidget(
        _app(
          locale: const Locale('es'),
          child: Builder(
            builder: (context) {
              spanishContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(
        getUrlVideoById(spanishContext, kVideoPropiedadesDeLosExponentes),
        isNotEmpty,
      );

      late BuildContext englishContext;
      await tester.pumpWidget(
        _app(
          locale: const Locale('en'),
          child: Builder(
            builder: (context) {
              englishContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(
        getUrlVideoById(
          englishContext,
          kVideoPropiedadesLogaritmoIgualACero,
        ),
        isEmpty,
      );
      expect(getUrlVideoById(englishContext, 'unknown-video'), isNull);
    },
  );

  testWidgets(
    'main navigation opens compact destinations selected by the user',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_app(child: const Menu()));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      await tester.tap(find.text('Tareas').last);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('To-Do List'), findsOneWidget);

      await tester.tap(find.text('Favoritos').last);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Favoritos'), findsAtLeastNWidgets(1));
    },
  );
}

Widget _app({
  required Widget child,
  TaskData? taskData,
  Locale locale = const Locale('es'),
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(locale),
      ),
      ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ChangeNotifierProvider<TaskData>.value(value: taskData ?? TaskData()),
      ChangeNotifierProvider<FavoritesNotifier>(
        create: (_) => FavoritesNotifier(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: child,
    ),
  );
}
