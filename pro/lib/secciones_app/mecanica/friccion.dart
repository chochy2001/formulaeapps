import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class Friccion extends StatefulWidget {
  const Friccion({super.key});

  @override
  FriccionState createState() => FriccionState();
}

class FriccionState extends State<Friccion> {
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
                    AppLocalizations.of(context)!.friccion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.friccion,
                        widgetName: kWidgetFriccion,
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
                                title: AppLocalizations.of(context)!.friccion,
                                widgetName: kWidgetFriccion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.friccion,
                                widgetName: kWidgetFriccion,
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
                  Latex(formulaText: r"F_{\text{neta}} = F_t - F_f"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F_f = \mu F_n = \mu F_g = \mu m g"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F_g = m g"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F_f = \mu F_n"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F_n = F_g \cos\theta = m g \cos\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F_f = \mu F_n = \mu m g \cos\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F_t = m g \operatorname{sen}\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetFriccion),
            const DescargarPDF(url: kWidgetFriccion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
