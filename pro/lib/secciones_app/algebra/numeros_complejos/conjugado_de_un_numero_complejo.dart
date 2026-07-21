import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ConjugadoNumerosComplejos extends StatefulWidget {
  const ConjugadoNumerosComplejos({super.key});

  @override
  ConjugadoNumerosComplejosState createState() =>
      ConjugadoNumerosComplejosState();
}

class ConjugadoNumerosComplejosState extends State<ConjugadoNumerosComplejos> {
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
                      AppLocalizations.of(context)!.conjugadoDeUnNumeroComplejo,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.conjugadoDeUnNumeroComplejo,
                          widgetName: kWidgetConjugadoDeUnNumeroComplejo,
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
                                  )!.conjugadoDeUnNumeroComplejo,
                                  widgetName:
                                      kWidgetConjugadoDeUnNumeroComplejo,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.conjugadoDeUnNumeroComplejo,
                                  widgetName:
                                      kWidgetConjugadoDeUnNumeroComplejo,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width),
                        const Latex(formulaText: r"z=a+bi"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conjugado,
                        ),
                        const SizedBox(height: kEspacioEntreBotones - 15),
                        const Latex(formulaText: r"z=a-bi"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.propiedadesDelConjugado,
                        ),
                        const Column(
                          children: [
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"\overline{z+w}=\bar z+\bar w"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"z+\bar z=2a"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"z-\bar z=2bi"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                              formulaText: r"\overline{zw}=\bar z \cdot \bar w",
                            ),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                              formulaText:
                                  r"z\in \mathbb R \rightarrow \bar z = z",
                            ),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"|z|^2=z\bar z \geq 0"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                              formulaText: r"\frac{1}{z}=\frac{\bar z}{|z|^2}",
                            ),
                            SizedBox(height: kEspacioEntreBotones),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetConjugadoDeUnNumeroComplejo),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetConjugadoDeUnNumeroComplejo),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
