import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FuncionesTrigonometricas extends StatefulWidget {
  const FuncionesTrigonometricas({super.key});
  @override
  State<FuncionesTrigonometricas> createState() =>
      _FuncionesTrigonometricasState();
}

class _FuncionesTrigonometricasState extends State<FuncionesTrigonometricas> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(onBannerReady: () { if (mounted) setState(() {}); });
  }


  Widget get adContainer => _ads.banner;

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.funcionesTrigonometricas,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .funcionesTrigonometricas,
                            widgetName:
                                kWidgetFuncionesTrigonometricasTrigonometria),
                      );
                      return IconButton(
                        icon: isFavorite
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border),
                        color: isFavorite ? Colors.white : Colors.white,
                        onPressed: () {
                          setState(() {
                            if (isFavorite) {
                              favoritesNotifier.removeFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .funcionesTrigonometricas,
                                    widgetName:
                                        kWidgetFuncionesTrigonometricasTrigonometria),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .funcionesTrigonometricas,
                                    widgetName:
                                        kWidgetFuncionesTrigonometricasTrigonometria),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin = \frac{CO}{H}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos = \frac{CA}{H}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\tan = \frac{CO}{CA}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\cot = \frac{CA}{CO} = \frac{1}{\tan}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\sec = \frac{H}{CA} = \frac{1}{\cos}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\csc = \frac{H}{CO} = \frac{1}{\sin}"),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetFuncionesTrigonometricasTrigonometria,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetFuncionesTrigonometricasTrigonometria,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
