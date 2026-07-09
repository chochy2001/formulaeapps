import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MultiplicacionDeMatrices extends StatefulWidget {
  @override
  _MultiplicacionDeMatricesState createState() =>
      _MultiplicacionDeMatricesState();
}

class _MultiplicacionDeMatricesState extends State<MultiplicacionDeMatrices> {
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
                    AppLocalizations.of(context)!.multiplicacionDeMatrices,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .multiplicacionDeMatrices,
                            widgetName: kWidgetMultiplicacionDeMatrices),
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
                                        .multiplicacionDeMatrices,
                                    widgetName:
                                        kWidgetMultiplicacionDeMatrices),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .multiplicacionDeMatrices,
                                    widgetName:
                                        kWidgetMultiplicacionDeMatrices),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sea,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A = \begin{pmatrix}a & b & c\\d & e & f\\g & h & i\\\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"B = \begin{pmatrix}j & k & l\\m & n & o\\p & q & r\\\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.multiplicacionEscalar,
                        ),
                        const Latex(
                            formulaText:
                                r"kA = k\cdot \begin{pmatrix}a & b & c\\d & e & f\\g & h & i\\\end{pmatrix}  =\begin{pmatrix}ka & kb & kc\\kd & ke & kf\\kg & kh & ki\\\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.productoMatrices,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A\cdot B =\begin{pmatrix}a & b & c\\d & e & f\\g & h & i\\\end{pmatrix}\cdot\begin{pmatrix}j & k & l\\m & n & o\\p & q & r\\\end{pmatrix}= \begin{pmatrix}aj+bm+cp & ak+bn+cq & al+bo+cr\\dj+em+fp & dk+en+fq & dl+eo+fr\\gj+hm+ip & gk+hn+iq & gl+ho+ir\\\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMultiplicacionDeMatrices,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMultiplicacionDeMatrices,
                  ),
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
                      children: [
                        const Notas(),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .condicionProductoMatrices,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"m\times n \thinspace n\times v"),
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
