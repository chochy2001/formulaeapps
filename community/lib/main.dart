import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../constantes/export_constantes.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulae/core/observability/observability_bootstrap.dart';
import 'package:formulae/menu.dart';
import 'package:formulae/routes.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../chat_gpt/api_consts.dart' as bff_consts;
import '../chat_gpt/chats_provider.dart';
import '../chat_gpt/models_provider.dart';
import '../models/task_data.dart';
import 'dart:ui' as ui;

import 'package:formulae/screens_personalizados/configuracion.dart';

import 'l10n/l10n.dart';

// Placeholder values rejected at startup in --release mode per spec §FR-006.
const _placeholderSecrets = <String>{
  '',
  'PLACEHOLDER_DEV_NOT_FOR_PROD',
  'replace-with-real-hex-secret',
};

void _assertBffSecretsConfigured() {
  if (!kReleaseMode) return;
  if (_placeholderSecrets.contains(bff_consts.jwtSharedSecret)) {
    throw StateError(
      'BFF JWT_SHARED_SECRET is a placeholder value in --release mode. '
      'Provide a real secret via --dart-define=JWT_SHARED_SECRET=<hex32>.',
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Spec §FR-006: refuse to launch a release build with placeholder JWT secret.
  _assertBffSecretsConfigured();
  // Fleet observability (Crashlytics + PostHog): off by default until
  // ENABLE_* + credential dart-defines are supplied (CapGym#79 pattern).
  await bootstrapObservability();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (AdMobConfig.adsEnabled) {
    MobileAds.instance.initialize();
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final favoritesNotifier = await FavoritesNotifier.loadFavorites();
  final deviceLocale =
      ui.PlatformDispatcher.instance.locale; // obtén el locale del sistema

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(
            create: (context) => LocaleProvider(deviceLocale)),
        ChangeNotifierProvider<ModelsProvider>(
          create: (context) => ModelsProvider(),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider<TaskData>(
          create: (context) => TaskData(),
        ),
        // Usa el favoritesNotifier que ya has inicializado y cargado
        ChangeNotifierProvider<FavoritesNotifier>.value(
            value: favoritesNotifier),
      ],
      child: MyApp(favoritesNotifier: favoritesNotifier),
    ),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  final FavoritesNotifier favoritesNotifier;

  const MyApp({super.key, required this.favoritesNotifier});

  static MyAppState? _myAppState;

  static void restartApp() {
    _myAppState?.restartApp();
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  @override
  void initState() {
    super.initState();
    MyApp._myAppState = this;
  }

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      navigatorKey: navigatorKey,
      title: 'Formulae Pro',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Provider.of<LocaleProvider>(context).locale,
      supportedLocales: L10n.all,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            //Menu Icon color changed to white
            iconTheme: IconThemeData(color: Colors.white)),
        fontFamily: 'Poppins',
        primarySwatch: PaletaColores.kFondo,
        scaffoldBackgroundColor: kColorFondo,
        primaryColor: kColorFondo,
      ),
      darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kColorFondo,
          primaryColor: kColorFondo,
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Poppins')),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => const Menu(),
      ),
    );
  }
}
