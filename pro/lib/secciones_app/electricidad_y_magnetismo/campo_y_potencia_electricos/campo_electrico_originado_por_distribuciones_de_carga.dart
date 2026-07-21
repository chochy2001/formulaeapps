import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CampoElectricoOriginadoPorDistribucionesDeCarga extends StatefulWidget {
  const CampoElectricoOriginadoPorDistribucionesDeCarga({super.key});

  @override
  State<CampoElectricoOriginadoPorDistribucionesDeCarga> createState() =>
      _CampoElectricoOriginadoPorDistribucionesDeCargaState();
}

class _CampoElectricoOriginadoPorDistribucionesDeCargaState
    extends State<CampoElectricoOriginadoPorDistribucionesDeCarga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.campoElectricoDistribucionesCarga,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.campoElectricoDistribucionesCarga,
                    widgetName:
                        kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga,
                  ),
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
                            title: AppLocalizations.of(
                              context,
                            )!.campoElectricoDistribucionesCarga,
                            widgetName:
                                kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.campoElectricoDistribucionesCarga,
                            widgetName:
                                kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: [
                TextoEcuaciones(AppLocalizations.of(context)!.cargaPuntual),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\vec{E} = k \frac{q}{r^2}\hat{r}"),
                const ZoomImagePersonalizado(urlImagen: kUrlImagenCargaPuntual),
                const SizedBox(height: 90.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.distribucionDiscretaCargasPuntuales,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\vec{E} = \sum_{i=1}^{n} k \frac{q_i}{r^2}\hat{r}",
                ),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenDistribucionDiscretaDeCargasPuntuales,
                ),
                const SizedBox(height: 30.0),
                TextoEcuaciones(AppLocalizations.of(context)!.lineaInfinita),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"\vec{E} = \frac{2 k \lambda}{r}\hat{r}",
                ),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenLineaInfinita,
                ),
                const SizedBox(height: 90.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.discoCargaUniforme,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\vec{E} = \frac{\sigma}{2 \epsilon _0} \left( 1 - \frac{z}{\sqrt{z^2 + R^2}} \right) \hat{r}",
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenDiscoConCargaUniforme,
                ),
                const SizedBox(height: 90.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.superficieInfinita,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\vec{E} = \frac{\sigma}{ 2 \epsilon _0} \hat{r}",
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenSuperficieInfinita,
                ),
                TextoEcuaciones(AppLocalizations.of(context)!.segmentoLinea),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\vec{E} = k \frac{\lambda L}{y \sqrt{y^2 + \frac{L^2}{4}}}\hat{j}",
                ),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenSegmentoDeLinea,
                ),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
