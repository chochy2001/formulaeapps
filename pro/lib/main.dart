import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulae/app/flavor_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';

import '../../../constantes/export_constantes.dart';
import '../chat_gpt/chats_provider.dart';
import '../chat_gpt/models_provider.dart';
import 'menus/menu.dart';
import '../routes.dart';
import 'l10n/l10n.dart';
import 'package:timezone/data/latest.dart' as tz;

// Define flutterLocalNotificationsPlugin y navigatorKey como variables globales
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() => bootstrap(FormulaeConfig.current);

Future<void> bootstrap(FormulaeConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //todo cambiar icono de android
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launch_image');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification),
    macOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification),
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

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
      child: MyApp(favoritesNotifier: favoritesNotifier, config: config),
    ),
  );
}

Future<void> onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // Aquí puedes agregar la lógica para manejar la acción de recibir la notificación
  // Por ejemplo, podrías mostrar un diálogo con el título y el cuerpo de la notificación
}

class MyApp extends StatefulWidget {
  final FavoritesNotifier favoritesNotifier;
  final FormulaeConfig config;

  const MyApp({
    Key? key,
    required this.favoritesNotifier,
    required this.config,
  }) : super(key: key);

  static MyAppState? _myAppState;

  static void restartApp() {
    _myAppState?.restartApp();
  }

  @override
  MyAppState createState() => _myAppState = MyAppState();
}

class MyAppState extends State<MyApp> {
  Key key = UniqueKey();

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
      title: widget.config.appTitle,
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
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Poppins')
          //Added darkTheme to fix the buttons visibility issues in dark mode (Android).
          //Trying to ensure proper contrast.
          ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => const Menu(),
      ),
    );
  }
}
