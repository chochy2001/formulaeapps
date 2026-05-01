import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class FormaComplejaDeLasSeriesDeFourier extends StatefulWidget {
  const FormaComplejaDeLasSeriesDeFourier({Key? key}) : super(key: key);

  @override
  FormaComplejaDeLasSeriesDeFourierState createState() =>
      FormaComplejaDeLasSeriesDeFourierState();
}

class FormaComplejaDeLasSeriesDeFourierState
    extends State<FormaComplejaDeLasSeriesDeFourier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChatGPTButton(
                    child: TituloPersonalizado(
                      AppLocalizations.of(context)!
                          .formaComplejaDeLasSeriesDeFourier,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .formaComplejaDeLasSeriesDeFourier,
                            widgetName:
                                kWidgetFormaComplejaDeLasSeriesDeFourier),
                      );
                      return IconButton(
                        icon: isFavorite
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border),
                        color: isFavorite ? Colors.white : Colors.white,
                        onPressed: () {
                          setState(() {
                            if (isFavorite) {
                              favoritesNotifier.removeFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .formaComplejaDeLasSeriesDeFourier,
                                    widgetName:
                                        kWidgetFormaComplejaDeLasSeriesDeFourier),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .formaComplejaDeLasSeriesDeFourier,
                                    widgetName:
                                        kWidgetFormaComplejaDeLasSeriesDeFourier),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieComplejaFourier,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"f(t) = c_0+\sum_{n=1}^{\infty} (c_n e^{jn\omega _0 t}+c_{-n}e^{-jn\omega _0t})"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"f(t) = c_0+\sum_{n=1}^{\infty} c_n e^{jn\omega _0 t}+\sum_{n=-1}^{-\infty}c_{n}e^{jn\omega _0t}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"f(t) = \sum_{n=-\infty}^{\infty}c_{n}e^{jn\omega _0t}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .coeficientesSerieComplejaFourier,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"c_0 = \frac{1}{2}a_0 = \frac{1}{T}\int_{-T/2}^{T/2}f(t)dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"c_n = \frac{1}{2} (a_n-jb_n)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"c_n = \frac{1}{T}\int_{-T/2}^{T/2}f(t)e^{-jn\omega _0t}dt= \frac{1}{T}\int_{0}^{T}f(t)e^{-jn\omega _0t}dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"c_{-n} = \frac{1}{2}(a_n+jb_n)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"c_{-n} = \frac{1}{T}\int_{-T/2}^{T/2}f(t)e^{jn\omega _0t}dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\cos(n\omega _0 t) = \frac{1}{2}(e^{jn\omega _0 t}+e^{-jn\omega _0t})"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\sin(n\omega _0 t) = \frac{1}{2j}(e^{jn\omega _0 t}-e^{-jn\omega _0t})"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.seObtieneAnterior,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a_n = 2\mathrm{Re}[c_n]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"b_n = -2\mathrm{Im}[c_n]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a_0 = 2c_0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.teniendo,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"c_n = |c_n|e^{j\phi n}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"c_{-n} = |c_n|e^{-j\phi n}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.porLoTanto,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"|c_n| = \frac{1}{2}\sqrt{a_n^2+b_n^2}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\phi _n = \tan ^{-1}\left(-\frac{b_n}{a_n}\right)"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetFormaComplejaDeLasSeriesDeFourier,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetFormaComplejaDeLasSeriesDeFourier,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
