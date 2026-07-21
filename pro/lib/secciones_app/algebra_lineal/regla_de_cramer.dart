import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ReglaDeCramer extends StatefulWidget {
  const ReglaDeCramer({super.key});

  @override
  ReglaDeCramerState createState() => ReglaDeCramerState();
}

class ReglaDeCramerState extends State<ReglaDeCramer> {
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
                      AppLocalizations.of(context)!.reglaCramer,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(context)!.reglaCramer,
                          widgetName: kWidgetReglaDeCramer,
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
                                  )!.reglaCramer,
                                  widgetName: kWidgetReglaDeCramer,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.reglaCramer,
                                  widgetName: kWidgetReglaDeCramer,
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
                        TextoEcuaciones(AppLocalizations.of(context)!.si),
                        const Latex(formulaText: r"Ax = b"),
                        TextoEcuaciones(AppLocalizations.of(context)!.entonces),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"x_j = \frac{\det A_j}{\det A}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetReglaDeCramer),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetReglaDeCramer),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(color: kColorFondo, width: 8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A_j"),
                        const SizedBox(height: 5),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.matrizResultante,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"x_j"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.incognita,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r""),
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
