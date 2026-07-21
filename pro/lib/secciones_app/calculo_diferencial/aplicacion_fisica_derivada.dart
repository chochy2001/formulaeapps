import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AplicacionFisicaDerivada extends StatefulWidget {
  const AplicacionFisicaDerivada({super.key});

  @override
  AplicacionFisicaDerivadaState createState() =>
      AplicacionFisicaDerivadaState();
}

class AplicacionFisicaDerivadaState extends State<AplicacionFisicaDerivada> {
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
                    AppLocalizations.of(context)!.aplicacionFisicaDerivada,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.aplicacionFisicaDerivada,
                        widgetName: kWidgetAplicacionFisicaDerivada,
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
                                )!.aplicacionFisicaDerivada,
                                widgetName: kWidgetAplicacionFisicaDerivada,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.aplicacionFisicaDerivada,
                                widgetName: kWidgetAplicacionFisicaDerivada,
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
                  Latex(formulaText: r"v_f^{2} = 2ae"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"v_f = v_i + a\cdot t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"v_f = a\cdot t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e = v\cdot t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"e = \left(\frac{v_f + v_i}{2}\right)\cdot t",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"e = v_i\cdot t + \frac{a\cdot t^{2}}{2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e = \frac{a\cdot t^{2}}{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e = \frac{v_f\cdot t}{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e = e_0 + v_0\,t + \frac{a\,t^{2}}{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"v_m = \frac{\Delta s}{\Delta t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"v_{inst} = \frac{ds}{dt}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a_m = \frac{\Delta v}{\Delta t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a_{inst} = \frac{dv}{dt}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a_{inst} = \frac{d^{2}s}{dt^{2}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P_m = \frac{\Delta w}{\Delta t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P = \frac{dw}{dt}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a = \frac{v_f - v_i}{t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a = \frac{v}{t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a_m = \frac{v_f - v_i}{t_f - t_i}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a = \frac{v_f}{t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"t = \frac{e}{v}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"t = \frac{v_f - v_i}{a}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P = \frac{w}{t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"f(x) = \varphi(x) \;\Rightarrow\; f'(x) = \varphi'(x)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAplicacionFisicaDerivada),
            const DescargarPDF(url: kWidgetAplicacionFisicaDerivada),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
