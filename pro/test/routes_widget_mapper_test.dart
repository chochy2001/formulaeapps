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

// Commit ad9e863 expanded the route table from 300 to 427 entries and the
// favorites table from 261 to 382. Legacy entries include screens that need
// native WebView implementations, so this test is strict over the expansion
// it was introduced to protect rather than swallowing errors from old routes.
const _routesAddedByContentExpansion = 127;
const _widgetsAddedByContentExpansion = 121;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Application routes', () {
    test('keeps the expected route table shape', () {
      final routes = getApplicationRoutes();
      expect(routes, hasLength(427));
      expect(routes.keys.toSet(), hasLength(routes.length));
      expect(routes.keys.every((route) => route.startsWith('/')), isTrue);
    });

    testWidgets(
      'mounts each route added by the content expansion without errors',
      (tester) async {
        final routes = getApplicationRoutes();
        var mounted = 0;
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final entry
            in routes.entries.take(_routesAddedByContentExpansion)) {
          if (_routesRequiringPlatformChannels.contains(entry.key)) {
            continue;
          }

          await tester.pumpWidget(
            _buildHarness(
              favoritesNotifier: FavoritesNotifier(),
              homeBuilder: entry.value,
            ),
          );
          await tester.pump();
          expect(
            tester.takeException(),
            isNull,
            reason: 'Route ${entry.key} must build without Flutter errors',
          );
          mounted++;
        }

        expect(mounted, _routesAddedByContentExpansion);
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
      'mounts each formula widget added by the expansion without errors',
      (tester) async {
        var mounted = 0;
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final entry
            in widgetTable.entries.take(_widgetsAddedByContentExpansion)) {
          await tester.pumpWidget(
            _buildHarness(
              favoritesNotifier: FavoritesNotifier(),
              homeBuilder: entry.value,
            ),
          );
          await tester.pump();
          expect(
            tester.takeException(),
            isNull,
            reason: 'Favorite ${entry.key} must build without Flutter errors',
          );
          mounted++;
        }

        expect(mounted, _widgetsAddedByContentExpansion);
      },
      timeout: const Timeout(Duration(minutes: 45)),
    );
  });
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
