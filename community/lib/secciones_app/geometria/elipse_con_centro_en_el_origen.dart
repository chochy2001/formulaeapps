import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ElipseConCentroEnElOrigen extends StatefulWidget {
  const ElipseConCentroEnElOrigen({super.key});
  @override
  State<ElipseConCentroEnElOrigen> createState() =>
      _ElipseConCentroEnElOrigenState();
}

class _ElipseConCentroEnElOrigenState extends State<ElipseConCentroEnElOrigen> {
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
                    AppLocalizations.of(context)!.elipseConCentroEnElOrigen,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .elipseConCentroEnElOrigen,
                            widgetName: kWidgetElipseConCentroEnElOrigen),
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
                                        .elipseConCentroEnElOrigen,
                                    widgetName:
                                        kWidgetElipseConCentroEnElOrigen),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .elipseConCentroEnElOrigen,
                                    widgetName:
                                        kWidgetElipseConCentroEnElOrigen),
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
                  const ZoomImagePersonalizado(
                      urlImagen: kUrlImagenElipseCentroEnElOrigen),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.centroOrigenEjeFocalX,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{x^2}{a^2}+\frac{y^2}{b^2} = 1"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"F(c,0)\space\space F'(-c,0)\space\space e = c/a"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"V(a,0)\space\space\space\space\space V'(-a,0)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"B(0,b)\space\space\space\space\space B'(0,-b)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{V'V} = 2a \space\space\space\space\space \overline{F'F} = 2c"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{B'B} = 2b \space\space\space\space\space \overline{LR}= 2b^2/a"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"R(c,-b^2/a)\space\space\space\space\space R'(-c,-b^2/a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"L(c,b^2/a)\space\space\space\space\space L'(-c,b^2/a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.centroOrigenEjeFocalY,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{x^2}{b^2}+\frac{y^2}{a^2} = 1"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"F(0,c)\space\space F'(0,-c)\space\space e = c/a"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"V(0,a)\space\space\space\space\space V'(0,-a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"B(b,0)\space\space\space\space\space B'(-b,0)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{V'V} = 2a \space\space\space\space\space \overline{F'F} = 2c"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{B'B} = 2b \space\space\space\space\space \overline{LR}= 2b^2/a"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"R(b^2/a,c)\space\space\space\space\space R'(b^2/a,-c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"L(-b^2/a,c)\space\space\space\space\space L'(-b^2/a,-c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.ecuacionGeneralElipse,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"Ax^2+By^2+Dx+Ey+F = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetElipseConCentroEnElOrigen,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetElipseConCentroEnElOrigen,
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
