import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class FraccionesParcialesIntegral extends StatefulWidget {
  const FraccionesParcialesIntegral({super.key});

  @override
  FraccionesParcialesIntegralState createState() =>
      FraccionesParcialesIntegralState();
}

class FraccionesParcialesIntegralState
    extends State<FraccionesParcialesIntegral> {
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
                    AppLocalizations.of(context)!.fraccionesParcialesIntegral,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.fraccionesParcialesIntegral,
                        widgetName: kWidgetFraccionesParcialesIntegral,
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
                                )!.fraccionesParcialesIntegral,
                                widgetName: kWidgetFraccionesParcialesIntegral,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.fraccionesParcialesIntegral,
                                widgetName: kWidgetFraccionesParcialesIntegral,
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
                        r"\int \frac{P(x)}{(x-a_1)(x-a_2)\cdots(x-a_n)}\,dx = \int \left( \frac{A_1}{x-a_1} + \frac{A_2}{x-a_2} + \cdots + \frac{A_n}{x-a_n} \right) dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{P(x)}{(x-a)^k}\,dx = \int \left( \frac{A_1}{x-a} + \frac{A_2}{(x-a)^2} + \frac{A_3}{(x-a)^3} + \cdots + \frac{A_k}{(x-a)^k} \right) dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{P(x)}{(a_1x^2+b_1x+c_1)\cdots(a_nx^2+b_nx+c_n)}\,dx = \int \left( \frac{A_1x+B_1}{a_1x^2+b_1x+c_1} + \cdots + \frac{A_nx+B_n}{a_nx^2+b_nx+c_n} \right) dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{P(x)}{(a_1x^2+b_1x+c_1)^k}\,dx = \int \left( \frac{A_1x+B_1}{a_1x^2+b_1x+c_1} + \frac{A_2x+B_2}{(a_1x^2+b_1x+c_1)^2} + \cdots + \frac{A_kx+B_k}{(a_1x^2+b_1x+c_1)^k} \right) dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetFraccionesParcialesIntegral),
            const DescargarPDF(url: kWidgetFraccionesParcialesIntegral),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
