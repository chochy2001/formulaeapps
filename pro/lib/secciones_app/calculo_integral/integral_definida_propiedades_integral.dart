import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class IntegralDefinidaPropiedadesIntegral extends StatefulWidget {
  const IntegralDefinidaPropiedadesIntegral({super.key});

  @override
  IntegralDefinidaPropiedadesIntegralState createState() =>
      IntegralDefinidaPropiedadesIntegralState();
}

class IntegralDefinidaPropiedadesIntegralState
    extends State<IntegralDefinidaPropiedadesIntegral> {
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
                    )!.integralDefinidaPropiedadesIntegral,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.integralDefinidaPropiedadesIntegral,
                        widgetName: kWidgetIntegralDefinidaPropiedadesIntegral,
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
                                )!.integralDefinidaPropiedadesIntegral,
                                widgetName:
                                    kWidgetIntegralDefinidaPropiedadesIntegral,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.integralDefinidaPropiedadesIntegral,
                                widgetName:
                                    kWidgetIntegralDefinidaPropiedadesIntegral,
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
                        r"\int_{a}^{b} f(x)\,dx = \left.F(x)\right]_{a}^{b} = F(b) - F(a)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int_{a}^{b} f(x)\,dx = -\int_{b}^{a} f(x)\,dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int_{a}^{b} f(x)\,dx = \int_{a}^{c} f(x)\,dx + \int_{c}^{b} f(x)\,dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int_{a}^{b} f(x)\,dx = (b-a)\,f(c), \quad a < c < b",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetIntegralDefinidaPropiedadesIntegral),
            const DescargarPDF(url: kWidgetIntegralDefinidaPropiedadesIntegral),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
