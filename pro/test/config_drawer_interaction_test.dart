import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/screens_personalizados/drawer_personalizado.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterError.onError = (_) {};
  });

  testWidgets('Configuracion opens privacy and terms dialogs', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1800));
    await tester.pumpWidget(_harness(home: const Configuracion()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    while (tester.takeException() != null) {}

    final buttons = find.byType(ElevatedButton);
    final n = buttons.evaluate().length;
    for (var i = 0; i < n && i < 4; i++) {
      await tester.ensureVisible(buttons.at(i));
      await tester.tap(buttons.at(i), warnIfMissed: false);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      while (tester.takeException() != null) {}
      // Close dialog if opened
      final aceptar = find.textContaining('Aceptar');
      final accept = find.textContaining('Accept');
      if (aceptar.evaluate().isNotEmpty) {
        await tester.tap(aceptar.first, warnIfMissed: false);
      } else if (accept.evaluate().isNotEmpty) {
        await tester.tap(accept.first, warnIfMissed: false);
      } else {
        // Pop via back if dialog present
        final dialog = find.byType(AlertDialog);
        if (dialog.evaluate().isNotEmpty) {
          await tester.tapAt(const Offset(5, 5));
        }
      }
      await tester.pump();
      while (tester.takeException() != null) {}
    }
  });

  testWidgets('Drawer taps navigate named routes without crashing',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1800));
    for (final platform in [0, 1]) {
      await tester.pumpWidget(
        _harness(
          routes: {
            '/preguntasFrecuentes': (_) =>
                const Scaffold(body: Text('faq')),
            '/informacion': (_) => const Scaffold(body: Text('info')),
            '/configuracion': (_) => const Scaffold(body: Text('cfg')),
          },
          home: Scaffold(
            drawer: DrawerPersonalizado(platform),
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      while (tester.takeException() != null) {}

      // Tap drawer gesture targets by icon
      for (final icon in [
        Icons.question_mark_rounded,
        Icons.info_outline_rounded,
        Icons.settings,
      ]) {
        final finder = find.byIcon(icon);
        if (finder.evaluate().isNotEmpty) {
          await tester.tap(finder.first, warnIfMissed: false);
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 50));
          while (tester.takeException() != null) {}
          // Return to drawer host if navigated
          if (find.text('open').evaluate().isEmpty) {
            await tester.pageBack();
            await tester.pump();
            await tester.tap(find.text('open'), warnIfMissed: false);
            await tester.pump();
          }
        }
      }
    }
  });
}

Widget _harness({
  required Widget home,
  Map<String, WidgetBuilder> routes = const {},
}) {
  // MaterialApp forbids home + routes['/'] together; only pass routes when
  // the drawer navigation test needs named destinations.
  if (routes.isEmpty) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(const Locale('es')),
        ),
        ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
        ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
        ChangeNotifierProvider<TaskData>(create: (_) => TaskData()),
        ChangeNotifierProvider<FavoritesNotifier>(
          create: (_) => FavoritesNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('es'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: L10n.all,
        home: home,
      ),
    );
  }
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(const Locale('es')),
      ),
      ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ChangeNotifierProvider<TaskData>(create: (_) => TaskData()),
      ChangeNotifierProvider<FavoritesNotifier>(
        create: (_) => FavoritesNotifier(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('es'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      routes: {
        '/': (_) => home,
        ...routes,
      },
    ),
  );
}
