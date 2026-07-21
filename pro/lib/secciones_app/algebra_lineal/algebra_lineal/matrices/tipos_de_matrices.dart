import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AlgebraLinealMatricesTiposDeMatrices extends StatefulWidget {
  const AlgebraLinealMatricesTiposDeMatrices({super.key});

  @override
  AlgebraLinealMatricesTiposDeMatricesState createState() =>
      AlgebraLinealMatricesTiposDeMatricesState();
}

class AlgebraLinealMatricesTiposDeMatricesState
    extends State<AlgebraLinealMatricesTiposDeMatrices> {
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
                    )!.algebraLinealMatricesTiposDeMatrices,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.algebraLinealMatricesTiposDeMatrices,
                        widgetName: kWidgetAlgebraLinealMatricesTiposDeMatrices,
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
                                )!.algebraLinealMatricesTiposDeMatrices,
                                widgetName:
                                    kWidgetAlgebraLinealMatricesTiposDeMatrices,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.algebraLinealMatricesTiposDeMatrices,
                                widgetName:
                                    kWidgetAlgebraLinealMatricesTiposDeMatrices,
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
                  Latex(
                    formulaText:
                        r"A = (a_{ij}), \quad B = (b_{ij}) \;\Rightarrow\; A = B \iff (a_{ij}) = (b_{ij})",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"A^{K+1} = A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"A^{2} = A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"A^{P} = \underbrace{A \times A \times \cdots \times A}_{P \text{ veces}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"A^{P} = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"A^{2} = I"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"A^{t} = -A"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAlgebraLinealMatricesTiposDeMatrices),
            const DescargarPDF(
              url: kWidgetAlgebraLinealMatricesTiposDeMatrices,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
