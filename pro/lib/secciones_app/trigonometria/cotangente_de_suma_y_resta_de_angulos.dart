import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CotangenteDeSumaYRestaDeAngulos extends StatefulWidget {
  const CotangenteDeSumaYRestaDeAngulos({super.key});

  @override
  CotangenteDeSumaYRestaDeAngulosState createState() =>
      CotangenteDeSumaYRestaDeAngulosState();
}

class CotangenteDeSumaYRestaDeAngulosState
    extends State<CotangenteDeSumaYRestaDeAngulos> {
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
                    AppLocalizations.of(
                      context,
                    )!.cotangenteDeSumaYRestaDeAngulos,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.cotangenteDeSumaYRestaDeAngulos,
                        widgetName: kWidgetCotangenteDeSumaYRestaDeAngulos,
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
                                )!.cotangenteDeSumaYRestaDeAngulos,
                                widgetName:
                                    kWidgetCotangenteDeSumaYRestaDeAngulos,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.cotangenteDeSumaYRestaDeAngulos,
                                widgetName:
                                    kWidgetCotangenteDeSumaYRestaDeAngulos,
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
                        r"\cot(A \pm B) = \dfrac{\cot A \cot B \mp 1}{\cot B \pm \cot A}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCotangenteDeSumaYRestaDeAngulos),
            const DescargarPDF(url: kWidgetCotangenteDeSumaYRestaDeAngulos),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
