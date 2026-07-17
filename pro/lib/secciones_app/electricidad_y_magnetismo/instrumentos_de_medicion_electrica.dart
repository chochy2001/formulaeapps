import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class InstrumentosDeMedicionElectrica extends StatefulWidget {
  const InstrumentosDeMedicionElectrica({super.key});

  @override
  InstrumentosDeMedicionElectricaState createState() => InstrumentosDeMedicionElectricaState();
}

class InstrumentosDeMedicionElectricaState extends State<InstrumentosDeMedicionElectrica> {
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
                    AppLocalizations.of(context)!.instrumentosDeMedicionElectrica,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.instrumentosDeMedicionElectrica,
                        widgetName: kWidgetInstrumentosDeMedicionElectrica,
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
                                title: AppLocalizations.of(context)!.instrumentosDeMedicionElectrica,
                                widgetName: kWidgetInstrumentosDeMedicionElectrica,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.instrumentosDeMedicionElectrica,
                                widgetName: kWidgetInstrumentosDeMedicionElectrica,
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
                  Latex(formulaText: r"R_{x} = R_{3}\,\frac{R_{2}}{R_{1}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"R_{x} = R_{3}\,\frac{I_{2}}{I_{1}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"R_{m} = \frac{V_{B} - I_{g} R_{g}}{I_{g}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"R = \frac{I_{g} R_{g}}{I - I_{g}}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetInstrumentosDeMedicionElectrica),
            const DescargarPDF(url: kWidgetInstrumentosDeMedicionElectrica),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
