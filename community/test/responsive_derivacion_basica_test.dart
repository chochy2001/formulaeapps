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
import 'package:formulae/secciones_app/calculo_diferencial/derivacion_basica_diferencial.dart';
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

  testWidgets('derivation cards fit every supported locale and viewport',
      (tester) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));

    for (final locale in const [Locale('es'), Locale('en')]) {
      for (final width in [320.0, 600.0, 900.0, 1440.0]) {
        await tester.binding.setSurfaceSize(Size(width, 1200));
        await tester.pumpWidget(_harness(locale));
        await tester.pump();

        expect(
          tester.takeException(),
          isNull,
          reason:
              'DerivacionBasica must fit ${locale.languageCode} at $width px',
        );
      }
    }
  });
}

Widget _harness(Locale locale) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(locale)),
      ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ChangeNotifierProvider<TaskData>(create: (_) => TaskData()),
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
      home: const DerivacionBasicaDiferencial(),
    ),
  );
}
