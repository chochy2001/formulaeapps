import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MatrizIdentidad extends StatefulWidget {
  const MatrizIdentidad({super.key});

  @override
  MatrizIdentidadState createState() => MatrizIdentidadState();
}

class MatrizIdentidadState extends State<MatrizIdentidad> {
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
                      AppLocalizations.of(context)!.propiedadesDeLasMatrices,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(context)!.matrizIdentidad,
                          widgetName: kWidgetMatrizidentidad,
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
                                  )!.matrizIdentidad,
                                  widgetName: kWidgetMatrizidentidad,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.matrizIdentidad,
                                  widgetName: kWidgetMatrizidentidad,
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.matrizIdentidadI,
                        ),
                        const SizedBox(height: 30),
                        const Latex(
                          formulaText:
                              r"{I = \begin{pmatrix}1 & 0 & 0\\0 & 1 & 0\\0 & 0 & 1\end{pmatrix} }",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.propiedadesDeLaMatrizIdentidad,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"I^{-1} = I"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"I^k = I"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cdot I = I \cdot A = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetMatrizidentidad),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetMatrizidentidad),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(color: kColorFondo, width: 8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.laDiagonalPrincipalEstaCompuestaPorUnos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: 10.0),
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
