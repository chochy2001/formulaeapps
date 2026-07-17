import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ReglaDeSarrus extends StatefulWidget {
  const ReglaDeSarrus({super.key});
  @override
  State<ReglaDeSarrus> createState() => _ReglaDeSarrusState();
}

class _ReglaDeSarrusState extends State<ReglaDeSarrus> {
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
                    AppLocalizations.of(context)!.reglaSarrus,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.reglaSarrus,
                            widgetName: kWidgetReglaDeSarrus),
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
                                        .reglaSarrus,
                                    widgetName: kWidgetReglaDeSarrus),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .reglaSarrus,
                                    widgetName: kWidgetReglaDeSarrus),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.sea,
                      ),
                      const Latex(
                          formulaText:
                              r"A = \begin{bmatrix}a & b & c\\d & e & f\\g & h & i\\\end{bmatrix} \rightarrow \begin{bmatrix}a & b & c\\d & e & f\\g & h & i\\a & b & c\\d & e & f\\\end{bmatrix} "),

                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.determinante,
                      ),
                      //Imagen
                      const ZoomImagePersonalizado(
                          urlImagen: kUrlImagenReglaDeSarrus),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Latex(
                            formulaText: r"\det A = aei+dhc+gbf-ceg-fha-ibd"),
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                    ],
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetReglaDeSarrus,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetReglaDeSarrus,
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
                        const SizedBox(
                          height: 10,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.soloAplicaMatrices,
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
