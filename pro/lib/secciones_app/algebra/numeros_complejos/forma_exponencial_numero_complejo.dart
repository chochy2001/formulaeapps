import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class NumerosComplejosFormaExponencialNumeroComplejo extends StatefulWidget {
  const NumerosComplejosFormaExponencialNumeroComplejo({super.key});

  @override
  NumerosComplejosFormaExponencialNumeroComplejoState createState() => NumerosComplejosFormaExponencialNumeroComplejoState();
}

class NumerosComplejosFormaExponencialNumeroComplejoState extends State<NumerosComplejosFormaExponencialNumeroComplejo> {
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
                    AppLocalizations.of(context)!.numerosComplejosFormaExponencialNumeroComplejo,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.numerosComplejosFormaExponencialNumeroComplejo,
                        widgetName: kWidgetNumerosComplejosFormaExponencialNumeroComplejo,
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
                                title: AppLocalizations.of(context)!.numerosComplejosFormaExponencialNumeroComplejo,
                                widgetName: kWidgetNumerosComplejosFormaExponencialNumeroComplejo,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.numerosComplejosFormaExponencialNumeroComplejo,
                                widgetName: kWidgetNumerosComplejosFormaExponencialNumeroComplejo,
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
                  Latex(formulaText: r"z = r\,e^{i\phi}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e^{i\phi} = \cos\phi + i\,\operatorname{sen}\phi"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e^{-i\phi} = \cos\phi - i\,\operatorname{sen}\phi = \frac{1}{\cos\phi + i\,\operatorname{sen}\phi}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\left|e^{i\phi}\right| = \sqrt{\cos^{2}\phi + \operatorname{sen}^{2}\phi} = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\cos\phi = \frac{e^{i\phi} + e^{-i\phi}}{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\operatorname{sen}\phi = \frac{e^{i\phi} - e^{-i\phi}}{2i}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\ln z = \ln r + i(\phi + 2\pi k)"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetNumerosComplejosFormaExponencialNumeroComplejo),
            const DescargarPDF(url: kWidgetNumerosComplejosFormaExponencialNumeroComplejo),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
