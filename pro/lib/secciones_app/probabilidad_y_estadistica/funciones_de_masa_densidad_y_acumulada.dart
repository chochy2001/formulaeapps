import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class FuncionesDeMasaDensidadYAcumulada extends StatefulWidget {
  const FuncionesDeMasaDensidadYAcumulada({super.key});

  @override
  FuncionesDeMasaDensidadYAcumuladaState createState() =>
      FuncionesDeMasaDensidadYAcumuladaState();
}

class FuncionesDeMasaDensidadYAcumuladaState
    extends State<FuncionesDeMasaDensidadYAcumulada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChatGPTButton(
                  child: TituloPersonalizado(
                    AppLocalizations.of(
                      context,
                    )!.funcionesDeMasaDensidadYAcumulada,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.funcionesDeMasaDensidadYAcumulada,
                        widgetName: kWidgetFuncionesDeMasaDensidadYAcumulada,
                      ),
                    );
                    return IconButton(
                      icon: isFavorite
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoritesNotifier.removeFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.funcionesDeMasaDensidadYAcumulada,
                                widgetName:
                                    kWidgetFuncionesDeMasaDensidadYAcumulada,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.funcionesDeMasaDensidadYAcumulada,
                                widgetName:
                                    kWidgetFuncionesDeMasaDensidadYAcumulada,
                              ),
                            );
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const ZoomPersonalizado(
              child: Column(
                children: [
                  Latex(formulaText: r"0 \leq P_{x}(X_{0}) \leq 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sum_{X_{0}} P_{x}(X_{0}) = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"P(a < X \leq b) = \int_{X_{0}=a}^{b} f_{x}(X_{0}) \, dX_{0}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"0 \leq f_{x}(X_{0}) \leq \infty"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int_{X_{0}=-\infty}^{\infty} f_{x}(X_{0}) \, dX_{0} = 1",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"P_{x}(X_{0}) = \begin{cases} \sum_{X \leq X_{0}} P_{x}(X_{0}) & X_{0} \ \text{discreta} \\ \int_{X_{0}=-\infty}^{X_{0}} f_{x}(X_{0}) \, dX_{0} & X_{0} \ \text{continua} \end{cases}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"P_{x}(\infty) = 1, \qquad P_{x}(-\infty) = 0",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P(a < X \leq b) = P_{x}(b) - P_{x}(a)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dX_{0}} P_{x}(X_{0}) = f_{x}(X_{0})",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetFuncionesDeMasaDensidadYAcumulada),
            const DescargarPDF(url: kWidgetFuncionesDeMasaDensidadYAcumulada),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
