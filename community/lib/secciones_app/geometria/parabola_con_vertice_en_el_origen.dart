import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ParabolaConVerticeEnElOrigen extends StatefulWidget {
  @override
  _ParabolaConVerticeEnElOrigenState createState() =>
      _ParabolaConVerticeEnElOrigenState();
}

class _ParabolaConVerticeEnElOrigenState
    extends State<ParabolaConVerticeEnElOrigen> {
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
                    AppLocalizations.of(context)!.parabolaConVerticeEnElOrigen,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .parabolaConVerticeEnElOrigen,
                            widgetName: kWidgetParabolaConVerticeEnElOrigen),
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
                                        .parabolaConVerticeEnElOrigen,
                                    widgetName:
                                        kWidgetParabolaConVerticeEnElOrigen),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .parabolaConVerticeEnElOrigen,
                                    widgetName:
                                        kWidgetParabolaConVerticeEnElOrigen),
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
                      urlImagen: kUrlImagenParabolaConVerticeEnElOrigen),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextoEcuaciones(
                                AppLocalizations.of(context)!.focoA0,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextoEcuaciones(
                                AppLocalizations.of(context)!.foco0A,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"y^2 = 4ax \space\space\space\space x^2 = 4ay"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"x = -a \space\space\space\space y = -a"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"L(a,2a)\space\space\space\space L(-2a,a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"R(a,-2a)\space\space\space\space R(2a,a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{LR} = |4a|\space\space\space\space\overline{LR} = |4a|"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextoEcuaciones(
                                AppLocalizations.of(context)!.focoMenosA0,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextoEcuaciones(
                                AppLocalizations.of(context)!.foco0MenosA,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"y^2 = -4ax\space\space\space\space x^2 = -4ay"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"x = a\space\space\space\space y = a"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"L(-a,2a)\space\space\space\space L(-2a,-a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"R(-a,-2a)\space\space\space\space R(2a,-a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{LR} = |4a|\space\space\space\space\overline{LR} = |4a|"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.ecuacionGeneralParabola,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.ejeFocalX,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"y^2+Dx+Ey+F=0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.ejeFocalY,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"x^2+Dx+Ey+F=0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetParabolaConVerticeEnElOrigen,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetParabolaConVerticeEnElOrigen,
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
