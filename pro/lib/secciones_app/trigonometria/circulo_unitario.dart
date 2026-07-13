import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CirculoUnitario extends StatefulWidget {
  const CirculoUnitario({super.key});

  @override
  CirculoUnitarioState createState() => CirculoUnitarioState();
}

class CirculoUnitarioState extends State<CirculoUnitario> {
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
                    AppLocalizations.of(context)!.circuloUnitario,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.circuloUnitario,
                        widgetName: kWidgetCirculoUnitario,
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
                                title: AppLocalizations.of(context)!.circuloUnitario,
                                widgetName: kWidgetCirculoUnitario,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.circuloUnitario,
                                widgetName: kWidgetCirculoUnitario,
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
                  Latex(formulaText: r"x^{2} + y^{2} = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(x,\; y) = (\cos\theta,\; \operatorname{sen}\theta)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(\cos 0^{\circ},\; \operatorname{sen} 0^{\circ}) = (1,\; 0)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(\cos 90^{\circ},\; \operatorname{sen} 90^{\circ}) = (0,\; 1)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(\cos 180^{\circ},\; \operatorname{sen} 180^{\circ}) = (-1,\; 0)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(\cos 270^{\circ},\; \operatorname{sen} 270^{\circ}) = (0,\; -1)"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCirculoUnitario),
            const DescargarPDF(url: kWidgetCirculoUnitario),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
