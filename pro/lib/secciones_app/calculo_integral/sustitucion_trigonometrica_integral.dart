import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class SustitucionTrigonometricaIntegral extends StatefulWidget {
  const SustitucionTrigonometricaIntegral({super.key});

  @override
  SustitucionTrigonometricaIntegralState createState() => SustitucionTrigonometricaIntegralState();
}

class SustitucionTrigonometricaIntegralState extends State<SustitucionTrigonometricaIntegral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChatGPTButton(
                  child: TituloPersonalizado(
                    AppLocalizations.of(context)!.sustitucionTrigonometricaIntegral,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.sustitucionTrigonometricaIntegral,
                        widgetName: kWidgetSustitucionTrigonometricaIntegral,
                      ),
                    );
                    return IconButton(
                      icon: isFavorite
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoritesNotifier.removeFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.sustitucionTrigonometricaIntegral,
                                widgetName: kWidgetSustitucionTrigonometricaIntegral,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.sustitucionTrigonometricaIntegral,
                                widgetName: kWidgetSustitucionTrigonometricaIntegral,
                              ),
                            );
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const ZoomPersonalizado(
              child: Column(
                children: [
                  Latex(formulaText: r"u = a\tan\theta, \quad du = a\sec^{2}\theta\,d\theta, \quad \sqrt{u^{2}+a^{2}} = a\sec\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"u = a\sec\theta, \quad du = a\sec\theta\tan\theta\,d\theta, \quad \sqrt{u^{2}-a^{2}} = a\tan\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"u = a\sin\theta, \quad du = a\cos\theta\,d\theta, \quad \sqrt{a^{2}-u^{2}} = a\cos\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetSustitucionTrigonometricaIntegral),
            const DescargarPDF(url: kWidgetSustitucionTrigonometricaIntegral),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
