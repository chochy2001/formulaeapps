import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AceleracionYFuerzaCentripeta extends StatefulWidget {
  const AceleracionYFuerzaCentripeta({super.key});

  @override
  AceleracionYFuerzaCentripetaState createState() => AceleracionYFuerzaCentripetaState();
}

class AceleracionYFuerzaCentripetaState extends State<AceleracionYFuerzaCentripeta> {
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
                    AppLocalizations.of(context)!.aceleracionYFuerzaCentripeta,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.aceleracionYFuerzaCentripeta,
                        widgetName: kWidgetAceleracionYFuerzaCentripeta,
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
                                title: AppLocalizations.of(context)!.aceleracionYFuerzaCentripeta,
                                widgetName: kWidgetAceleracionYFuerzaCentripeta,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.aceleracionYFuerzaCentripeta,
                                widgetName: kWidgetAceleracionYFuerzaCentripeta,
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
                  Latex(formulaText: r"a = \frac{V^{2}}{r}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a = r\,\omega^{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F = m\,\frac{V^{2}}{r}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAceleracionYFuerzaCentripeta),
            const DescargarPDF(url: kWidgetAceleracionYFuerzaCentripeta),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
