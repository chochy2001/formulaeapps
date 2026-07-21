import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ReglaCadenaFuncionInversa extends StatefulWidget {
  const ReglaCadenaFuncionInversa({super.key});

  @override
  ReglaCadenaFuncionInversaState createState() =>
      ReglaCadenaFuncionInversaState();
}

class ReglaCadenaFuncionInversaState extends State<ReglaCadenaFuncionInversa> {
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
                    AppLocalizations.of(context)!.reglaCadenaFuncionInversa,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.reglaCadenaFuncionInversa,
                        widgetName: kWidgetReglaCadenaFuncionInversa,
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
                                )!.reglaCadenaFuncionInversa,
                                widgetName: kWidgetReglaCadenaFuncionInversa,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.reglaCadenaFuncionInversa,
                                widgetName: kWidgetReglaCadenaFuncionInversa,
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
                        r"\frac{dy}{dx}=\frac{dy}{du}\cdot\frac{du}{dx},\quad du\neq 0",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{dy}{dx}=\frac{1}{\dfrac{dx}{dy}},\quad \frac{dx}{dy}\neq 0",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetReglaCadenaFuncionInversa),
            const DescargarPDF(url: kWidgetReglaCadenaFuncionInversa),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
