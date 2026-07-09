import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class Hiperbola extends StatefulWidget {
  @override
  _HiperbolaState createState() => _HiperbolaState();
}

class _HiperbolaState extends State<Hiperbola> {
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
                    AppLocalizations.of(context)!.hiperbola,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.hiperbola,
                            widgetName: kWidgetHiperbola),
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
                                    title:
                                        AppLocalizations.of(context)!.hiperbola,
                                    widgetName: kWidgetHiperbola),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title:
                                        AppLocalizations.of(context)!.hiperbola,
                                    widgetName: kWidgetHiperbola),
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
                  const ZoomImagePersonalizado(urlImagen: kUrlImagenHiperbola),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"C(h,k)\space\space\space\space\space\space\space\space F(c,0)\space\space\space\space\space\space\space\space V(a,0)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextoEcuaciones(
                                AppLocalizations.of(context)!.horizontal,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextoEcuaciones(
                                AppLocalizations.of(context)!.vertical,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{x^2}{a^2}-\frac{y^2}{b^2} = 1\space\space\space\space\space\space\space\space\space\space\space\space\space \frac{y^2}{a^2}-\frac{x^2}{b^2} = 1"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"c = \sqrt{a^2+b^2}\space\space\space\space\space\space\space\space\space\space\space\space\space c = \sqrt{a^2+b^2}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"e = c/a\space\space\space\space\space\space\space\space\space\space\space\space\space e = c/a"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{LR} = 2b^2/a\space\space\space\space\space\space\space\space\space\space\space\space\space \overline{LR} = 2b^2/a"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetHiperbola,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetHiperbola,
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
