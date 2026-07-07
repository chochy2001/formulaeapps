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
    FlutterError.onError = (details) {
      final message = details.exceptionAsString();
      if (_isRenderFlexOverflow(message)) {
        return;
      }
      originalOnError?.call(details);
    };
  });

  tearDown(() {
    FlutterError.onError = originalOnError;
  });

  group('Application routes', () {
    test('keeps the expected route table shape', () {
      final routes = getApplicationRoutes();

      expect(routes, hasLength(300));
      expect(routes.keys.toSet(), hasLength(routes.length));
      expect(routes.keys.every((route) => route.startsWith('/')), isTrue);
      expect(routes.containsKey(kRutaMenu), isTrue);
      expect(routes.containsKey(kRutaFavorites), isTrue);
      expect(routes.containsKey(kRutaConfiguracion), isTrue);
      expect(routes.keys, containsAll(_routesRequiringPlatformChannels));
    });

    testWidgets(
      'builds each routable screen without framework exceptions',
      (tester) async {
        final routes = getApplicationRoutes();

        for (final entry in routes.entries) {
          if (_routesRequiringPlatformChannels.contains(entry.key)) {
            continue;
          }

          await tester.pumpWidget(
            _buildHarness(
              favoritesNotifier: FavoritesNotifier(),
              routes: routes,
              initialRoute: entry.key,
            ),
          );
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 400));

          expect(
            _takeUnexpectedException(tester),
            isNull,
            reason: 'La ruta ${entry.key} lanzó una excepción durante build.',
          );

          final navigatorContext = tester.element(find.byType(Navigator).first);
          final routeWidget = entry.value(navigatorContext);
          expect(
            routeWidget,
            isA<Widget>(),
            reason: 'La ruta ${entry.key} debe resolver a un Widget válido.',
          );
        }
      },
      timeout: const Timeout(Duration(minutes: 8)),
    );

    testWidgets(
      'still maps chat route to ChatScreen',
      (tester) async {
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

        final chatWidget = routes[kRutaChatGPT]!(context);

        expect(chatWidget, isA<ChatScreen>());
      },
    );
  });

  group('Favorites widget mapper', () {
    test('keeps the expected widget table shape', () {
      expect(widgetTable, hasLength(261));
      expect(widgetTable.keys.toSet(), hasLength(widgetTable.length));
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
      'resolves every mapped key to the expected widget type',
      (tester) async {
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

        for (final entry in widgetTable.entries) {
          final expectedWidget = entry.value(context);
          final mappedWidget = widgetMapper(entry.key, context);

          expect(
            mappedWidget.runtimeType,
            expectedWidget.runtimeType,
            reason:
                'El mapper para ${entry.key} debe resolver al tipo ${expectedWidget.runtimeType}.',
          );
        }
      },
      timeout: const Timeout(Duration(minutes: 8)),
    );
  });
}

Object? _takeUnexpectedException(WidgetTester tester) {
  Object? exception;
  while ((exception = tester.takeException()) != null) {
    final message = exception.toString();
    if (_isRenderFlexOverflow(message)) {
      continue;
    }
    return exception;
  }
  return null;
}

bool _isRenderFlexOverflow(String message) =>
    message.contains('A RenderFlex overflowed');

Widget _buildHarness({
  required FavoritesNotifier favoritesNotifier,
  Map<String, WidgetBuilder>? routes,
  String? initialRoute,
  WidgetBuilder? homeBuilder,
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
      routes: routes ?? const <String, WidgetBuilder>{},
      initialRoute: initialRoute,
      home: homeBuilder == null ? null : Builder(builder: homeBuilder),
    ),
  );
}
