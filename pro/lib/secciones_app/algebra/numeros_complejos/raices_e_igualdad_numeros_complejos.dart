import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class NumerosComplejosRaicesEIgualdadNumerosComplejos extends StatefulWidget {
  const NumerosComplejosRaicesEIgualdadNumerosComplejos({super.key});

  @override
  NumerosComplejosRaicesEIgualdadNumerosComplejosState createState() => NumerosComplejosRaicesEIgualdadNumerosComplejosState();
}

class NumerosComplejosRaicesEIgualdadNumerosComplejosState extends State<NumerosComplejosRaicesEIgualdadNumerosComplejos> {
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
                    AppLocalizations.of(context)!.numerosComplejosRaicesEIgualdadNumerosComplejos,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.numerosComplejosRaicesEIgualdadNumerosComplejos,
                        widgetName: kWidgetNumerosComplejosRaicesEIgualdadNumerosComplejos,
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
                                title: AppLocalizations.of(context)!.numerosComplejosRaicesEIgualdadNumerosComplejos,
                                widgetName: kWidgetNumerosComplejosRaicesEIgualdadNumerosComplejos,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.numerosComplejosRaicesEIgualdadNumerosComplejos,
                                widgetName: kWidgetNumerosComplejosRaicesEIgualdadNumerosComplejos,
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
                  Latex(formulaText: r"\sqrt{a \pm ib} = \sqrt{\frac{a + \sqrt{a^{2} + b^{2}}}{2}} \pm i\sqrt{\frac{-a + \sqrt{a^{2} + b^{2}}}{2}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sqrt[n]{1} = \cos\frac{2\pi k}{n} + i\,\operatorname{sen}\frac{2\pi k}{n}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a_{1} = a_{2} \ \text{y} \ b_{1} = b_{2} \implies z_{1} = z_{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"r_{1} = r_{2} \ \text{y} \ \phi_{1} = \phi_{2} + 2\pi k \implies z_{1} = z_{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetNumerosComplejosRaicesEIgualdadNumerosComplejos),
            const DescargarPDF(url: kWidgetNumerosComplejosRaicesEIgualdadNumerosComplejos),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
