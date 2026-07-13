import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ReflexionYAumentoFormaNewtoniana extends StatefulWidget {
  const ReflexionYAumentoFormaNewtoniana({super.key});

  @override
  ReflexionYAumentoFormaNewtonianaState createState() => ReflexionYAumentoFormaNewtonianaState();
}

class ReflexionYAumentoFormaNewtonianaState extends State<ReflexionYAumentoFormaNewtoniana> {
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
                    AppLocalizations.of(context)!.reflexionYAumentoFormaNewtoniana,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.reflexionYAumentoFormaNewtoniana,
                        widgetName: kWidgetReflexionYAumentoFormaNewtoniana,
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
                                title: AppLocalizations.of(context)!.reflexionYAumentoFormaNewtoniana,
                                widgetName: kWidgetReflexionYAumentoFormaNewtoniana,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.reflexionYAumentoFormaNewtoniana,
                                widgetName: kWidgetReflexionYAumentoFormaNewtoniana,
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
                  Latex(formulaText: r"N = \frac{360^{\circ}}{\alpha} - 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{\text{tamaño de la imagen}}{\text{tamaño del objeto}} = \frac{\text{distancia de la imagen}}{\text{distancia del objeto}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{I}{O} = -\frac{q}{p}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"M = \frac{I}{O}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetReflexionYAumentoFormaNewtoniana),
            const DescargarPDF(url: kWidgetReflexionYAumentoFormaNewtoniana),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
