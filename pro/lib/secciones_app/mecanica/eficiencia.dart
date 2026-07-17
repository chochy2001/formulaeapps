import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class Eficiencia extends StatefulWidget {
  const Eficiencia({super.key});

  @override
  EficienciaState createState() => EficienciaState();
}

class EficienciaState extends State<Eficiencia> {
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
                    AppLocalizations.of(context)!.eficiencia,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.eficiencia,
                        widgetName: kWidgetEficiencia,
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
                                title: AppLocalizations.of(context)!.eficiencia,
                                widgetName: kWidgetEficiencia,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.eficiencia,
                                widgetName: kWidgetEficiencia,
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
                  Latex(formulaText: r"e = \frac{Q_{Ent} - Q_{Sal}}{Q_{Ent}} \times 100"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e = \frac{T_{Ent} - T_{Sal}}{T_{Ent}} \times 100"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E = \frac{T_s}{T_e} \times 100"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E = \frac{P_s}{P_e} \times 100"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetEficiencia),
            const DescargarPDF(url: kWidgetEficiencia),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
