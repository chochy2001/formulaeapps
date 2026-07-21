import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class EntropiaYTeoriaCinetica extends StatefulWidget {
  const EntropiaYTeoriaCinetica({super.key});

  @override
  EntropiaYTeoriaCineticaState createState() => EntropiaYTeoriaCineticaState();
}

class EntropiaYTeoriaCineticaState extends State<EntropiaYTeoriaCinetica> {
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
                    AppLocalizations.of(context)!.entropiaYTeoriaCinetica,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.entropiaYTeoriaCinetica,
                        widgetName: kWidgetEntropiaYTeoriaCinetica,
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
                                )!.entropiaYTeoriaCinetica,
                                widgetName: kWidgetEntropiaYTeoriaCinetica,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.entropiaYTeoriaCinetica,
                                widgetName: kWidgetEntropiaYTeoriaCinetica,
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
                  Latex(formulaText: r"dS = \frac{dQ}{T}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E = \tfrac{1}{2} M v^{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E = \tfrac{3}{2} R T"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetEntropiaYTeoriaCinetica),
            const DescargarPDF(url: kWidgetEntropiaYTeoriaCinetica),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
