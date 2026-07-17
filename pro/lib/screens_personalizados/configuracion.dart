import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constantes/export_constantes.dart';
import '../l10n/l10n.dart';
import '../main.dart';
import '../widgets_personalizados/export_widgets_personalizados.dart';

const _kGooglePlayCancellationUrl =
    'https://support.google.com/googleplay/answer/7018481';
const _kAppleCancellationUrlEs = 'https://support.apple.com/es-lamr/HT202039';
const _kAppleCancellationUrlEn = 'https://support.apple.com/en-us/HT202039';
const _kFormulaeSupportUrlEs = 'https://formulaeapps.com/soporte/';
const _kFormulaeSupportUrlEn = 'https://formulaeapps.com/en/support/';

/// Returns the appropriate subscription-cancellation help URL for the current
/// runtime and [locale].
///
/// Mobile keeps the store-specific flow. Web and desktop cannot reliably know
/// which store owns a past subscription, so they use Formulae's localized
/// support page instead of leaving a URL uninitialized.
String subscriptionCancellationSupportUrl(
  Locale locale, {
  TargetPlatform? targetPlatform,
  bool isWeb = kIsWeb,
}) {
  final bool isSpanish = locale.languageCode.toLowerCase() == 'es';
  final String supportUrl =
      isSpanish ? _kFormulaeSupportUrlEs : _kFormulaeSupportUrlEn;

  if (isWeb) {
    return supportUrl;
  }

  switch (targetPlatform ?? defaultTargetPlatform) {
    case TargetPlatform.android:
      return '$_kGooglePlayCancellationUrl?hl=${isSpanish ? 'ES' : 'EN'}';
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return isSpanish ? _kAppleCancellationUrlEs : _kAppleCancellationUrlEn;
    case TargetPlatform.linux:
    case TargetPlatform.windows:
    case TargetPlatform.fuchsia:
      return supportUrl;
  }
}

class Configuracion extends StatelessWidget {
  const Configuracion({super.key});

  @override
  Widget build(BuildContext context) {
    final String cancellationSupportUrl = subscriptionCancellationSupportUrl(
      Localizations.localeOf(context),
    );
    return Scaffold(
      appBar: const AppBarHome(),
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.configuracion,
                  style: GoogleFonts.poppins(
                    textStyle: kEstiloTextoMenus,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const ImagenRemotaRobusta(
                  height: 200.0,
                  width: 200.0,
                  urlImagen: kUrlImagenFormulae,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  AppLocalizations.of(context)!.formulaePro,
                  style: GoogleFonts.poppins(
                    textStyle: kTextoBotones,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  AppLocalizations.of(context)!.desarrolladoPor,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: kTextoDelgado,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.contacto,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: kTextoDelgado,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                            vertical: MediaQuery.of(context).size.height * 0.02,
                          ),
                          backgroundColor: kColorBotones,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.politicaPrivacidad,
                            style: kTexto,
                          ),
                          content: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .politicaDePrivacidad,
                              style: kTextoBotonesDelgado,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                AppLocalizations.of(context)!.aceptar,
                                style: kTexto,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.politicaPrivacidad,
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                            vertical: MediaQuery.of(context).size.height * 0.02,
                          ),
                          backgroundColor: kColorBotones,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.terminosUso,
                            style: kTexto,
                          ),
                          content: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              AppLocalizations.of(context)!.terminosDeServicio,
                              style: kTextoBotonesDelgado,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                AppLocalizations.of(context)!.aceptar,
                                style: kTexto,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.terminosUso,
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                            vertical: MediaQuery.of(context).size.height * 0.02,
                          ),
                          backgroundColor: kColorBotones,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.cancelarSuscripciones,
                            style: kTexto,
                          ),
                          content: Text(
                            AppLocalizations.of(context)!.instrucciones,
                            style: kTextoBotonesDelgado,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                AppLocalizations.of(context)!.visitarWeb,
                                // Enlace: acento SECUNDARIO teal (6.56:1 sobre
                                // navy) para senalar la afordancia interactiva.
                                style: kTexto.copyWith(
                                  color: kColorAcentoSecundario,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                openURL(cancellationSupportUrl);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancelarSuscripciones,
                    style: kTextoBotonesDelgado.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : kColorFondo),
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: kColorBotones,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          title: Center(
                            child: Text(
                              AppLocalizations.of(context)!.seleccionarIdioma,
                              style: kTextoBotones,
                            ),
                          ),
                          content: Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            decoration: BoxDecoration(
                              color: kColorBotones, // Color de fondo
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: Column(
                                children: L10n.all
                                    .map<Widget>((locale) =>
                                        localeButton(locale, context))
                                    .toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cambiarIdioma,
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LocaleProvider with ChangeNotifier {
  Locale _locale;

  LocaleProvider(this._locale) {
    loadLocale();
  }

  Locale get locale => _locale;

  set locale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    saveLocale(locale);
    notifyListeners();
    MyApp.restartApp();
  }

  void saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode ?? '');
  }

  void loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('languageCode') ?? 'en';
    String countryCode = prefs.getString('countryCode') ?? '';
    _locale = Locale(languageCode, countryCode);
    notifyListeners();
  }
}

class LocaleSettings {
  static void setLocaleRaw(Locale locale, BuildContext context) {
    Provider.of<LocaleProvider>(context, listen: false).locale = locale;
  }
}

Widget localeButton(Locale locale, BuildContext context) {
  return ListTile(
    leading: Text(
      locale.languageCode.toUpperCase(),
      style: kTextoBotonesDelgado,
    ),
    title: Text(
      locale.languageCode == 'en'
          ? '🇺🇸     ${AppLocalizations.of(context)!.idiomaIngles}     🇬🇧'
          : '🇲🇽     ${AppLocalizations.of(context)!.idiomaEspaniol}     🇪🇸',
      style: kTextoBotonesDelgado,
    ),
    trailing: Provider.of<LocaleProvider>(context).locale == locale
        ? const Icon(Icons.check, color: Colors.white)
        : null,
    onTap: () {
      Navigator.pop(context);
      LocaleSettings.setLocaleRaw(locale, context);
    },
  );
}
