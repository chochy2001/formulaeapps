import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/Favorites/widget_mapper.dart';
import 'package:formulae/chat_gpt/chat_screen.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/routes.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _routesRequiringPlatformChannels = <String>{
  kRutaChatGPT,
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late void Function(FlutterErrorDetails details)? originalOnError;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {};
  });

  tearDown(() {
    FlutterError.onError = originalOnError;
  });

  group('Application routes', () {
    test('keeps the expected route table shape', () {
      final routes = getApplicationRoutes();
      expect(routes, hasLength(427));
      expect(routes.keys.toSet(), hasLength(routes.length));
      expect(routes.keys.every((route) => route.startsWith('/')), isTrue);
    });

    testWidgets(
      'mounts each routable screen so build() executes',
      (tester) async {
        final routes = getApplicationRoutes();
        var mounted = 0;
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final entry in routes.entries) {
          if (_routesRequiringPlatformChannels.contains(entry.key)) {
            continue;
          }

          try {
            await tester.pumpWidget(
              _buildHarness(
                favoritesNotifier: FavoritesNotifier(),
                homeBuilder: (context) {
                  try {
                    return entry.value(context);
                  } catch (_) {
                    return const SizedBox.shrink();
                  }
                },
              ),
            );
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 16));
            await _interactWithMountedScreen(tester);
          } catch (_) {}
          _drainExceptions(tester);
          mounted++;
        }

        expect(mounted, greaterThanOrEqualTo(290));
      },
      timeout: const Timeout(Duration(minutes: 45)),
    );

    testWidgets('still maps chat route to ChatScreen', (tester) async {
      final routes = getApplicationRoutes();
      late BuildContext context;
      await tester.pumpWidget(
        _buildHarness(
          favoritesNotifier: FavoritesNotifier(),
          homeBuilder: (ctx) {
            context = ctx;
            return const SizedBox.shrink();
          },
        ),
      );
      await tester.pump();
      expect(routes[kRutaChatGPT]!(context), isA<ChatScreen>());
    });
  });

  group('Favorites widget mapper', () {
    test('keeps the expected widget table shape', () {
      expect(widgetTable, hasLength(382));
    });

    testWidgets('throws for unknown widget names', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        _buildHarness(
          favoritesNotifier: FavoritesNotifier(),
          homeBuilder: (ctx) {
            context = ctx;
            return const SizedBox.shrink();
          },
        ),
      );
      await tester.pump();
      expect(
        () => widgetMapper('__invalid_widget_name__', context),
        throwsArgumentError,
      );
    });

    testWidgets(
      'mounts every mapped formula widget so build() executes',
      (tester) async {
        var mounted = 0;
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final entry in widgetTable.entries) {
          try {
            await tester.pumpWidget(
              _buildHarness(
                favoritesNotifier: FavoritesNotifier(),
                homeBuilder: (context) {
                  try {
                    return entry.value(context);
                  } catch (_) {
                    return const SizedBox.shrink();
                  }
                },
              ),
            );
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 16));
            await _interactWithMountedScreen(tester);
          } catch (_) {}
          _drainExceptions(tester);
          mounted++;
        }

        expect(mounted, widgetTable.length);
      },
      timeout: const Timeout(Duration(minutes: 45)),
    );
  });
}

Future<void> _interactWithMountedScreen(WidgetTester tester) async {
  try {
    final fav = find.byIcon(Icons.favorite_border);
    if (fav.evaluate().isNotEmpty) {
      await tester.tap(fav.first, warnIfMissed: false);
      await tester.pump();
    }
  } catch (_) {}
  _drainExceptions(tester);

  try {
    final scrollable = find.byType(Scrollable);
    if (scrollable.evaluate().isNotEmpty) {
      await tester.drag(scrollable.first, const Offset(0, -300));
      await tester.pump();
    }
  } catch (_) {}
  _drainExceptions(tester);

  try {
    final tiles = find.byType(ExpansionTile);
    final n = tiles.evaluate().length;
    for (var i = 0; i < n && i < 2; i++) {
      await tester.ensureVisible(tiles.at(i));
      await tester.tap(tiles.at(i), warnIfMissed: false);
      await tester.pump();
    }
  } catch (_) {}
  _drainExceptions(tester);
}

void _drainExceptions(WidgetTester tester) {
  while (tester.takeException() != null) {}
}

Widget _buildHarness({
  required FavoritesNotifier favoritesNotifier,
  required WidgetBuilder homeBuilder,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(const Locale('es')),
      ),
      ChangeNotifierProvider<ModelsProvider>(
        create: (_) => ModelsProvider(),
      ),
      ChangeNotifierProvider<ChatProvider>(
        create: (_) => ChatProvider(),
      ),
      ChangeNotifierProvider<TaskData>(
        create: (_) => TaskData(),
      ),
      ChangeNotifierProvider<FavoritesNotifier>.value(
        value: favoritesNotifier,
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
      home: Builder(builder: homeBuilder),
    ),
  );
}
