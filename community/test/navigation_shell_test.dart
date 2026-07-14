import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/ads/admob_config.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/menu.dart';
import 'package:formulae/models/task_data.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/widgets_personalizados/app_bar_home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AdMobConfig.adsEnabled = false;
  });

  tearDown(() {
    AdMobConfig.adsEnabled = true;
  });

  testWidgets('Home returns to the existing root route without duplicating it',
      (tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        routes: <String, WidgetBuilder>{
          '/': (_) => const Scaffold(body: Text('root route')),
          '/detail': (_) => const Scaffold(
                appBar: AppBarHome(),
                body: Text('detail route'),
              ),
        },
      ),
    );

    navigatorKey.currentState!.pushNamed('/detail');
    await tester.pumpAndSettle();
    expect(find.text('detail route'), findsOneWidget);
    expect(navigatorKey.currentState!.canPop(), isTrue);

    await tester.tap(find.byIcon(FontAwesomeIcons.houseChimneyCrack));
    await tester.pumpAndSettle();

    expect(find.text('root route'), findsOneWidget);
    expect(find.text('detail route'), findsNothing);
    expect(
      navigatorKey.currentState!.canPop(),
      isFalse,
      reason: 'Home must not push another instance of the root route.',
    );
  });

  testWidgets(
      'Menu uses compact and expanded navigation at the shared breakpoint',
      (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    for (final (double width, bool expectsRail) in <(double, bool)>[
      (320, false),
      (899, false),
      (900, true),
      (1440, true),
    ]) {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = Size(width, 900);
      await tester.pump();
      await tester.pumpWidget(_menuHarness());
      await tester.pump();

      final BuildContext menuContext = tester.element(find.byType(Menu));
      expect(MediaQuery.sizeOf(menuContext).width, width);
      expect(
        tester.takeException(),
        isNull,
        reason: 'Menu must fit a ${width.toInt()} px viewport.',
      );
      expect(
        find.byType(NavigationRail),
        expectsRail ? findsOneWidget : findsNothing,
        reason: 'Unexpected desktop navigation state at ${width.toInt()} px.',
      );
      expect(
        find.byType(BottomNavigationBar),
        expectsRail ? findsNothing : findsOneWidget,
      );
    }
  });
}

Widget _menuHarness() {
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
      home: const Menu(),
    ),
  );
}
