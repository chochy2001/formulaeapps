import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MediaGeometrica extends StatefulWidget {
  const MediaGeometrica({super.key});

  @override
  MediaGeometricaState createState() => MediaGeometricaState();
}

class MediaGeometricaState extends State<MediaGeometrica> {
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
                      AppLocalizations.of(context)!.mediaGeometrica,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title:
                                AppLocalizations.of(context)!.mediaGeometrica,
                            widgetName: kWidgetMediaGeometrica),
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
                                        .mediaGeometrica,
                                    widgetName: kWidgetMediaGeometrica),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .mediaGeometrica,
                                    widgetName: kWidgetMediaGeometrica),
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
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.datosNoAgrupados,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"\bar{X}_{G} = \sqrt[n]{x_1\cdot x_2 \cdot x_3\cdots x_n}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.datosAgrupados,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"\ln{(\bar{X}_{G})} = \frac{\sum_{i=1}^{n} f_i \cdot \ln{(MC_i)}}{n}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMediaGeometrica,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMediaGeometrica,
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
                        const Latex(formulaText: r"\bar{X}_G "),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.mediaGeometrica,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"x"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valoresConjuntoDatos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"f_i "),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.frecuenciaIntervaloi,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"MC_i"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.marcaClaseIntervaloi,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.numeroTotalDatos,
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
