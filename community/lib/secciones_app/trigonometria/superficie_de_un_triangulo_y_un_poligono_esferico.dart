import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class SuperficieDeUnTrianguloYUnPoligonoEsferico extends StatefulWidget {
  const SuperficieDeUnTrianguloYUnPoligonoEsferico({super.key});
  @override
  State<SuperficieDeUnTrianguloYUnPoligonoEsferico> createState() =>
      _SuperficieDeUnTrianguloYUnPoligonoEsfericoState();
}

class _SuperficieDeUnTrianguloYUnPoligonoEsfericoState
    extends State<SuperficieDeUnTrianguloYUnPoligonoEsferico> {
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
                    AppLocalizations.of(context)!
                        .superficieDeUnTrianguloYUnPoligonoEsferico,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .superficieDeUnTrianguloYUnPoligonoEsferico,
                            widgetName:
                                kWidgetSuperficieDeUnTrianguloYUnPoligonoEsferico),
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
                                        .superficieDeUnTrianguloYUnPoligonoEsferico,
                                    widgetName:
                                        kWidgetSuperficieDeUnTrianguloYUnPoligonoEsferico),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .superficieDeUnTrianguloYUnPoligonoEsferico,
                                    widgetName:
                                        kWidgetSuperficieDeUnTrianguloYUnPoligonoEsferico),
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
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .superficieTrianguloEsferico,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"S = \frac{\pi r^2}{180^\circ}(\alpha+\beta+\gamma-180^\circ)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .superficiePoligonoEsferico,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"S = \frac{\pi r^2}{180^\circ}(A_1+A_2+\cdots + A_n - (n-2)\cdot 180^\circ)"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSuperficieDeUnTrianguloYUnPoligonoEsferico,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSuperficieDeUnTrianguloYUnPoligonoEsferico,
                  ),

                  //Notas
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(
                        color: kColorFondo,
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Notas(),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"r"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.radioEsfera,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\alpha\space \beta\space \gamma\space "),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.angulosTriangulo,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A_1,A_2,\cdots,A_n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.angulosPoligono,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.numeroLadosPoligono,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
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
