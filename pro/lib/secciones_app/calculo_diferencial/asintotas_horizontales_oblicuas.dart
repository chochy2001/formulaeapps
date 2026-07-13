import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AsintotasHorizontalesOblicuas extends StatefulWidget {
  const AsintotasHorizontalesOblicuas({super.key});

  @override
  AsintotasHorizontalesOblicuasState createState() => AsintotasHorizontalesOblicuasState();
}

class AsintotasHorizontalesOblicuasState extends State<AsintotasHorizontalesOblicuas> {
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
                    AppLocalizations.of(context)!.asintotasHorizontalesOblicuas,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.asintotasHorizontalesOblicuas,
                        widgetName: kWidgetAsintotasHorizontalesOblicuas,
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
                                title: AppLocalizations.of(context)!.asintotasHorizontalesOblicuas,
                                widgetName: kWidgetAsintotasHorizontalesOblicuas,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.asintotasHorizontalesOblicuas,
                                widgetName: kWidgetAsintotasHorizontalesOblicuas,
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
                  Latex(formulaText: r"\lim_{x \to +\infty} f(x) = b"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to -\infty} f(x) = b"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y = m x + b"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to \infty} \left[ f(x) - (m x + b) \right] = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAsintotasHorizontalesOblicuas),
            const DescargarPDF(url: kWidgetAsintotasHorizontalesOblicuas),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
