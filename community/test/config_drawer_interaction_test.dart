import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/ads/admob_config.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/models/task_data.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/screens_personalizados/drawer_personalizado.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _drawerHostKey = ValueKey<String>('drawer-host');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AdMobConfig.adsEnabled = false;
  });

  tearDown(() {
    AdMobConfig.adsEnabled = true;
  });

  test('subscription management links are localized and platform-safe', () {
    expect(
      subscriptionManagementUrl(
        locale: const Locale('es'),
        platform: TargetPlatform.android,
        isWeb: false,
      ),
      'https://support.google.com/googleplay/answer/7018481?hl=es',
    );
    expect(
      subscriptionManagementUrl(
        locale: const Locale('en'),
        platform: TargetPlatform.android,
        isWeb: false,
      ),
      'https://support.google.com/googleplay/answer/7018481?hl=en',
    );
    expect(
      subscriptionManagementUrl(
        locale: const Locale('es'),
        platform: TargetPlatform.iOS,
        isWeb: false,
      ),
      'https://support.apple.com/es-lamr/HT202039',
    );
    expect(
      subscriptionManagementUrl(
        locale: const Locale('en'),
        platform: TargetPlatform.macOS,
        isWeb: false,
      ),
      'https://support.apple.com/en-us/HT202039',
    );

    for (final platform in [TargetPlatform.windows, TargetPlatform.linux]) {
      expect(
        subscriptionManagementUrl(
          locale: const Locale('es'),
          platform: platform,
          isWeb: false,
        ),
        isNull,
      );
    }
    expect(
      subscriptionManagementUrl(
        locale: const Locale('en'),
        platform: TargetPlatform.android,
        isWeb: true,
      ),
      isNull,
    );
  });

  testWidgets('Configuracion opens privacy and terms dialogs', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1800));
    await tester.pumpWidget(_harness(home: const Configuracion()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    _expectNoWidgetException(tester, 'Configuracion initial mount');

    final buttons = find.byType(ElevatedButton);
    final hasSubscriptionManagement = subscriptionManagementUrl(
          locale: const Locale('es'),
          platform: defaultTargetPlatform,
          isWeb: kIsWeb,
        ) !=
        null;
    expect(buttons, findsNWidgets(hasSubscriptionManagement ? 4 : 3));
    // This test covers the two dialogs named in its contract. Subscription and
    // language actions have their own platform/state behavior and are not
    // asserted as if they were privacy/terms dialogs.
    for (final index in [0, 1]) {
      await tester.ensureVisible(buttons.at(index));
      await tester.tap(buttons.at(index));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      _expectNoWidgetException(tester, 'Configuracion dialog $index opening');
      expect(find.byType(AlertDialog), findsOneWidget);
      final accept = find.text('Aceptar');
      expect(accept, findsOneWidget);
      await tester.tap(accept);
      await tester.pumpAndSettle();
      _expectNoWidgetException(tester, 'Configuracion dialog $index dismissal');
      expect(find.byType(AlertDialog), findsNothing);
    }
  });

  testWidgets('Drawer taps navigate named routes without crashing',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1800));
    for (final platform in [0, 1]) {
      await tester.pumpWidget(
        _harness(
          routes: {
            '/preguntasFrecuentes': (_) => const Scaffold(body: Text('faq')),
            '/informacion': (_) => const Scaffold(body: Text('info')),
            '/configuracion': (_) => const Scaffold(body: Text('cfg')),
          },
          home: Scaffold(
            key: _drawerHostKey,
            drawer: DrawerPersonalizado(platform),
            body: const SizedBox.shrink(),
          ),
        ),
      );
      await tester.pump();
      final drawerHostFinder = find.byKey(_drawerHostKey);
      expect(drawerHostFinder, findsOneWidget);
      final drawerHost = tester.state<ScaffoldState>(drawerHostFinder);
      drawerHost.openDrawer();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      _expectNoWidgetException(tester, 'Drawer platform $platform opening');
      expect(find.byType(Drawer), findsOneWidget);

      // Tap each named navigation target and assert its registered route.
      for (final entry in <IconData, String>{
        Icons.question_mark_rounded: 'faq',
        Icons.info_outline_rounded: 'info',
        Icons.settings: 'cfg',
      }.entries) {
        final icon = entry.key;
        final finder = find.byIcon(icon);
        expect(finder, findsOneWidget);
        await tester.ensureVisible(finder);
        await tester.tap(finder);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        _expectNoWidgetException(tester, 'Drawer platform $platform $icon');
        expect(find.text(entry.value), findsOneWidget);

        tester.state<NavigatorState>(find.byType(Navigator)).pop();
        await tester.pump(const Duration(milliseconds: 300));
        _expectNoWidgetException(tester, 'Drawer platform $platform return');
        drawerHost.openDrawer();
        await tester.pump(const Duration(milliseconds: 300));
        _expectNoWidgetException(tester, 'Drawer platform $platform reopen');
        expect(find.byType(Drawer), findsOneWidget);
      }
    }
  });
}

void _expectNoWidgetException(WidgetTester tester, String phase) {
  expect(tester.takeException(), isNull,
      reason: '$phase threw a widget exception');
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
