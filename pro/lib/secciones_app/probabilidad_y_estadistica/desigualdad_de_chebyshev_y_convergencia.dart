import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DesigualdadDeChebyshevYConvergencia extends StatefulWidget {
  const DesigualdadDeChebyshevYConvergencia({super.key});

  @override
  DesigualdadDeChebyshevYConvergenciaState createState() => DesigualdadDeChebyshevYConvergenciaState();
}

class DesigualdadDeChebyshevYConvergenciaState extends State<DesigualdadDeChebyshevYConvergencia> {
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
                    AppLocalizations.of(context)!.desigualdadDeChebyshevYConvergencia,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.desigualdadDeChebyshevYConvergencia,
                        widgetName: kWidgetDesigualdadDeChebyshevYConvergencia,
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
                                title: AppLocalizations.of(context)!.desigualdadDeChebyshevYConvergencia,
                                widgetName: kWidgetDesigualdadDeChebyshevYConvergencia,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.desigualdadDeChebyshevYConvergencia,
                                widgetName: kWidgetDesigualdadDeChebyshevYConvergencia,
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
                  Latex(formulaText: r"P\bigl( |X - E(X)| \geq t \bigr) \leq \left( \frac{\sigma_x}{t} \right)^{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"X_n = X_1, X_2, \ldots"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{n \to \infty} P\bigl( |X_n - L| > \epsilon \bigr) = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDesigualdadDeChebyshevYConvergencia),
            const DescargarPDF(url: kWidgetDesigualdadDeChebyshevYConvergencia),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
