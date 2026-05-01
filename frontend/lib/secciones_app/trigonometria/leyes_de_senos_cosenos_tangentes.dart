import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyesDeSenosCosenosTangentes extends StatefulWidget {
  const LeyesDeSenosCosenosTangentes({Key? key}) : super(key: key);

  @override
  LeyesDeSenosCosenosTangentesState createState() =>
      LeyesDeSenosCosenosTangentesState();
}

class LeyesDeSenosCosenosTangentesState
    extends State<LeyesDeSenosCosenosTangentes> {
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
                      AppLocalizations.of(context)!.leyDeSenosCosenosYTangente,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .leyDeSenosCosenosYTangente,
                            widgetName: kWidgetLeyesDeSenosCosenosTangentes),
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
                                        .leyDeSenosCosenosYTangente,
                                    widgetName:
                                        kWidgetLeyesDeSenosCosenosTangentes),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .leyDeSenosCosenosYTangente,
                                    widgetName:
                                        kWidgetLeyesDeSenosCosenosTangentes),
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
                          AppLocalizations.of(context)!.leySenos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{a}{\sin A} = \frac{b}{\sin B} = \frac{c}{\sin C}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.leyCosenos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a^2=b^2+c^2-2bc\cdot\cos A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"b^2=a^2+c^2-2ac\cdot\cos B"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"c^2=a^2+b^2-2ab\cdot\cos C"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\cos A = \frac{b^2+c^2-a^2}{2bc}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\cos B = \frac{a^2+c^2-b^2}{2ac}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\cos C = \frac{a^2+b^2-c^2}{2ab}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.teoremaTangente,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{a+b}{a-b} = \frac{\tan\left[\frac{A+B}{2}\right]}{tan \left[\frac{A-B}{2}\right]}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{a+c}{a-c} = \frac{\tan\left[\frac{A+C}{2}\right]}{tan \left[\frac{A-C}{2}\right]}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{b+c}{b-c} = \frac{\tan\left[\frac{B+C}{2}\right]}{tan \left[\frac{B-C}{2}\right]}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const Column(
                    children: [
                      VerPDF(
                        url: kWidgetLeyesDeSenosCosenosTangentes,
                      ),
                      //Descargar PDF
                      DescargarPDF(
                        url: kWidgetLeyesDeSenosCosenosTangentes,
                      ),
                    ],
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
