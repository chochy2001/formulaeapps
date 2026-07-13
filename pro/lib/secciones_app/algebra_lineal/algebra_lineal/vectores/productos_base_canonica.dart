import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AlgebraLinealVectoresProductosBaseCanonica extends StatefulWidget {
  const AlgebraLinealVectoresProductosBaseCanonica({super.key});

  @override
  AlgebraLinealVectoresProductosBaseCanonicaState createState() => AlgebraLinealVectoresProductosBaseCanonicaState();
}

class AlgebraLinealVectoresProductosBaseCanonicaState extends State<AlgebraLinealVectoresProductosBaseCanonica> {
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
                    AppLocalizations.of(context)!.algebraLinealVectoresProductosBaseCanonica,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.algebraLinealVectoresProductosBaseCanonica,
                        widgetName: kWidgetAlgebraLinealVectoresProductosBaseCanonica,
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
                                title: AppLocalizations.of(context)!.algebraLinealVectoresProductosBaseCanonica,
                                widgetName: kWidgetAlgebraLinealVectoresProductosBaseCanonica,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.algebraLinealVectoresProductosBaseCanonica,
                                widgetName: kWidgetAlgebraLinealVectoresProductosBaseCanonica,
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
                  Latex(formulaText: r"\hat{i} \cdot \hat{i} = 1, \qquad \hat{j} \cdot \hat{j} = 1, \qquad \hat{k} \cdot \hat{k} = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\hat{i} \cdot \hat{j} = \hat{i} \cdot \hat{k} = \hat{j} \cdot \hat{k} = 0, \qquad \hat{j} \cdot \hat{i} = \hat{k} \cdot \hat{i} = \hat{k} \cdot \hat{j} = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\hat{\imath} \times \hat{\jmath} = \hat{k}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAlgebraLinealVectoresProductosBaseCanonica),
            const DescargarPDF(url: kWidgetAlgebraLinealVectoresProductosBaseCanonica),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
