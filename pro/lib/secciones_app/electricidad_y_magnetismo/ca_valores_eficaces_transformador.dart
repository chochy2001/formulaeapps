import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CaValoresEficacesTransformador extends StatefulWidget {
  const CaValoresEficacesTransformador({super.key});

  @override
  CaValoresEficacesTransformadorState createState() =>
      CaValoresEficacesTransformadorState();
}

class CaValoresEficacesTransformadorState
    extends State<CaValoresEficacesTransformador> {
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
                    )!.caValoresEficacesTransformador,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.caValoresEficacesTransformador,
                        widgetName: kWidgetCaValoresEficacesTransformador,
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
                                )!.caValoresEficacesTransformador,
                                widgetName:
                                    kWidgetCaValoresEficacesTransformador,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.caValoresEficacesTransformador,
                                widgetName:
                                    kWidgetCaValoresEficacesTransformador,
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
                        r"\varepsilon_{inst} = \varepsilon_{max}\sin(2\pi f t)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"i_{inst} = i_{max}\sin(2\pi f t)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{\varepsilon_{p}}{\varepsilon_{s}} = \frac{N_{p}}{N_{s}} = \frac{I_{s}}{I_{p}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"i_{eff} = 0.707\, i_{max}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\varepsilon_{eff} = 0.707\, \varepsilon_{max}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCaValoresEficacesTransformador),
            const DescargarPDF(url: kWidgetCaValoresEficacesTransformador),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
