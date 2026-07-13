import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class RazonCambioTangenteNormal extends StatefulWidget {
  const RazonCambioTangenteNormal({super.key});

  @override
  RazonCambioTangenteNormalState createState() => RazonCambioTangenteNormalState();
}

class RazonCambioTangenteNormalState extends State<RazonCambioTangenteNormal> {
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
                    AppLocalizations.of(context)!.razonCambioTangenteNormal,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.razonCambioTangenteNormal,
                        widgetName: kWidgetRazonCambioTangenteNormal,
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
                                title: AppLocalizations.of(context)!.razonCambioTangenteNormal,
                                widgetName: kWidgetRazonCambioTangenteNormal,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.razonCambioTangenteNormal,
                                widgetName: kWidgetRazonCambioTangenteNormal,
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
                  Latex(formulaText: r"\frac{\Delta y}{\Delta x} = \tan a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta y = \tan a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{\Delta y}{\Delta x} = \tan \beta"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"m_{\tan} = f'(x)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y - y_1 = m\,(x - x_1)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y - y_1 = f'(x_1)\,(x - x_1)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y - f(x_1) = f'(x_1)\,(x - x_1)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y - y_1 = -\frac{1}{f'(x_1)}\,(x - x_1)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tan \theta = \frac{m_2 - m_1}{1 + m_2\cdot m_1}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\text{area} = \frac{1}{2}\left[(x_2 - x_1)(y_3 - y_1) - (x_3 - x_1)(y_2 - y_1)\right]"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetRazonCambioTangenteNormal),
            const DescargarPDF(url: kWidgetRazonCambioTangenteNormal),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
