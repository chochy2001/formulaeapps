import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class RepresentacionesDeNumerosComplejos extends StatefulWidget {
  const RepresentacionesDeNumerosComplejos({Key? key}) : super(key: key);

  @override
  RepresentacionesDeNumerosComplejosState createState() =>
      RepresentacionesDeNumerosComplejosState();
}

class RepresentacionesDeNumerosComplejosState
    extends State<RepresentacionesDeNumerosComplejos> {
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
                      AppLocalizations.of(context)!
                          .representacionesDeUnNumeroComplejo,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .representacionesDeUnNumeroComplejo,
                            widgetName:
                                kWidgetRepresentacionesDeUnNumeroComplejo),
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
                                        .representacionesDeUnNumeroComplejo,
                                    widgetName:
                                        kWidgetRepresentacionesDeUnNumeroComplejo),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .representacionesDeUnNumeroComplejo,
                                    widgetName:
                                        kWidgetRepresentacionesDeUnNumeroComplejo),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: kEspacioEntreBotones,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.enFormaBinomica,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Column(
                          children: [
                            Latex(formulaText: r"z=a+bi"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"z=r(\cos\theta +i\cdot \sin \theta)"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"\cos \theta = \frac{a}{r}"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"\sin\theta = \frac{b}{r}"),
                            SizedBox(height: kEspacioEntreBotones),
                          ],
                        ),

                        //Potencias de la unidad imaginaria
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.formaPolar,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Column(
                          children: [
                            Latex(formulaText: r"i=\sqrt{-1}"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"i^3=-i"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"i^2=-1"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"i^4=1"),
                            SizedBox(height: kEspacioEntreBotones),
                            SizedBox(
                              height: kEspacioEntreBotones,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetRepresentacionesDeUnNumeroComplejo,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetRepresentacionesDeUnNumeroComplejo,
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
                        const Latex(formulaText: r"a"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.parteReal,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"bi"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.parteImaginaria,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"r"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.modulo,
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
