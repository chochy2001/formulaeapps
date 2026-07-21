import 'package:flutter/material.dart';
import 'package:flutter_inappwebview_platform_interface/flutter_inappwebview_platform_interface.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/Favorites/widget_mapper.dart';
import 'package:formulae/ads/admob_config.dart';
import 'package:formulae/chat_gpt/chat_screen.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/models/task_data.dart';
import 'package:formulae/routes.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _routesRequiringPlatformChannels = <String>{kRutaChatGPT};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // The catalog contains embedded YouTube players. Widget tests exercise
    // their owning screens but do not have a native WebView implementation.
    // This explicit fake keeps the test focused on Formulae's widget tree
    // without discarding exceptions from the screens under test.
    InAppWebViewPlatform.instance ??= _TestInAppWebViewPlatform();
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AdMobConfig.adsEnabled = false;
  });

  tearDown(() {
    AdMobConfig.adsEnabled = true;
  });

  group('Application routes', () {
    test('keeps the expected route table shape', () {
      final routes = getApplicationRoutes();
      expect(routes, hasLength(298));
      expect(routes.keys.toSet(), hasLength(routes.length));
    });

    testWidgets(
      'mounts each routable screen so build() executes',
      (tester) async {
        final routes = getApplicationRoutes();
        final mountedRoutes = <String>[];
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final entry in routes.entries) {
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
          await tester.pump(const Duration(milliseconds: 16));
          _expectNoWidgetException(tester, 'route ${entry.key} initial mount');
          await _interactWithMountedScreen(tester, 'route ${entry.key}');
          _expectNoWidgetException(tester, 'route ${entry.key} interactions');
          mountedRoutes.add(entry.key);
        }

        expect(
          mountedRoutes,
          hasLength(routes.length - _routesRequiringPlatformChannels.length),
        );
      },
      timeout: const Timeout(Duration(minutes: 45)),
    );

    testWidgets('maps chat route to ChatScreen', (tester) async {
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
      expect(widgetTable, hasLength(259));
    });

    testWidgets(
      'mounts every mapped formula widget so build() executes',
      (tester) async {
        final mountedWidgets = <String>[];
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final entry in widgetTable.entries) {
          await tester.pumpWidget(
            _buildHarness(
              favoritesNotifier: FavoritesNotifier(),
              homeBuilder: entry.value,
            ),
          );
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 16));
          _expectNoWidgetException(tester, 'widget ${entry.key} initial mount');
          await _interactWithMountedScreen(tester, 'widget ${entry.key}');
          _expectNoWidgetException(tester, 'widget ${entry.key} interactions');
          mountedWidgets.add(entry.key);
        }

        expect(mountedWidgets, hasLength(widgetTable.length));
      },
      timeout: const Timeout(Duration(minutes: 45)),
    );
  });
}

Future<void> _interactWithMountedScreen(
  WidgetTester tester,
  String subject,
) async {
  final fav = find.byIcon(Icons.favorite_border);
  if (fav.evaluate().isNotEmpty) {
    await tester.ensureVisible(fav.first);
    await tester.tap(fav.first);
    await tester.pump();
    _expectNoWidgetException(tester, '$subject favorite toggle');
  }

  final scrollable = find.byType(Scrollable);
  if (scrollable.evaluate().isNotEmpty) {
    await tester.drag(scrollable.first, const Offset(0, -300));
    await tester.pump();
    _expectNoWidgetException(tester, '$subject scroll');
  }

  final tiles = find.byType(ExpansionTile);
  final n = tiles.evaluate().length;
  for (var i = 0; i < n && i < 2; i++) {
    final tile = tiles.at(i);
    if (tile.evaluate().isEmpty) continue;
    await tester.ensureVisible(tile);
    await tester.tap(tile);
    await tester.pump();
    _expectNoWidgetException(tester, '$subject expansion tile $i');
  }
}

void _expectNoWidgetException(WidgetTester tester, String phase) {
  expect(
    tester.takeException(),
    isNull,
    reason: '$phase threw a widget exception',
  );
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
      ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ChangeNotifierProvider<TaskData>(create: (_) => TaskData()),
      ChangeNotifierProvider<FavoritesNotifier>.value(value: favoritesNotifier),
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

class _TestInAppWebViewPlatform extends InAppWebViewPlatform {
  @override
  PlatformInAppWebViewWidget createPlatformInAppWebViewWidget(
    PlatformInAppWebViewWidgetCreationParams params,
  ) => _TestInAppWebViewWidget(params);
}

class _TestInAppWebViewWidget extends PlatformInAppWebViewWidget {
  _TestInAppWebViewWidget(super.params) : super.implementation();

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();

  @override
  T controllerFromPlatform<T>(PlatformInAppWebViewController controller) =>
      controller as T;

  @override
  void dispose() {}
}
