import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CuantilesParaDatosAgrupados extends StatefulWidget {
  const CuantilesParaDatosAgrupados({super.key});

  @override
  CuantilesParaDatosAgrupadosState createState() =>
      CuantilesParaDatosAgrupadosState();
}

class CuantilesParaDatosAgrupadosState
    extends State<CuantilesParaDatosAgrupados> {
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
                  ChatGPTButton(
                    child: TituloPersonalizado(
                      AppLocalizations.of(context)!.cuantilesParaDatosAgrupados,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .cuantilesParaDatosAgrupados,
                            widgetName: kWidgetCuantilesParaDatosAgrupados),
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
                                        .cuantilesParaDatosAgrupados,
                                    widgetName:
                                        kWidgetCuantilesParaDatosAgrupados),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .cuantilesParaDatosAgrupados,
                                    widgetName:
                                        kWidgetCuantilesParaDatosAgrupados),
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
                        Latex(
                            formulaText:
                                r"P_p = LIR_p + \frac{\left(\frac{P}{100}\cdot n\right)-fa_{antP}}{f_p}\cdot c"),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetCuantilesParaDatosAgrupados,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetCuantilesParaDatosAgrupados,
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
                      children: [
                        const Notas(),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"P_p"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.percentilP,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"LIR_p"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .limiteInferiorRealClasePercentilP,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"fa_{antP}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .frecuenciaAcumuladaClaseAnteriorPercentil,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"f_p"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .frecuenciaClasePercentil,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.numeroTotalDatos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"c"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.amplitudClasePercentil,
                        ),
                        const SizedBox(height: 10),
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
