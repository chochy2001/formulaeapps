import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ProcesosTermodinamicos extends StatefulWidget {
  const ProcesosTermodinamicos({super.key});

  @override
  ProcesosTermodinamicosState createState() => ProcesosTermodinamicosState();
}

class ProcesosTermodinamicosState extends State<ProcesosTermodinamicos> {
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
                    AppLocalizations.of(context)!.procesosTermodinamicos,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.procesosTermodinamicos,
                        widgetName: kWidgetProcesosTermodinamicos,
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
                                title: AppLocalizations.of(context)!.procesosTermodinamicos,
                                widgetName: kWidgetProcesosTermodinamicos,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.procesosTermodinamicos,
                                widgetName: kWidgetProcesosTermodinamicos,
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
                  Latex(formulaText: r"\Delta W = -\,\Delta U"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta Q = \Delta U"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta Q = \Delta W"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetProcesosTermodinamicos),
            const DescargarPDF(url: kWidgetProcesosTermodinamicos),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
