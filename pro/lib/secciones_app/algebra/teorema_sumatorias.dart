import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class TeoremaSumatorias extends StatefulWidget {
  const TeoremaSumatorias({Key? key}) : super(key: key);

  @override
  TeoremaSumatoriasState createState() => TeoremaSumatoriasState();
}

class TeoremaSumatoriasState extends State<TeoremaSumatorias> {
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
                      AppLocalizations.of(context)!.teoremaDeSumatorias,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .teoremaDeSumatorias,
                            widgetName: kWidgetTeoremaDeSumatorias),
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
                                        .teoremaDeSumatorias,
                                    widgetName: kWidgetTeoremaDeSumatorias),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .teoremaDeSumatorias,
                                    widgetName: kWidgetTeoremaDeSumatorias),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        Latex(
                            formulaText:
                                r"\sum_{i=1}^n f(i)=c\sum_{i=1}^nf(i)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\sum_{i=1}[f(i)\pm g(i)]=\sum_{i=1}^nf(i)\pm\sum_{i=1}^ng(i)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\sum_{i=1}^nf(i) =\sum_{i=1}^mf(i)+\sum_{i=m+1}^nf(i)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sum_{i=1}^n c=nc"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sum_{i=1}^n i=\frac{n(n+1)}{2}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\sum_{i=1}^n i^2=\frac{n(n+1)(2n+1)}{6}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\sum_{i=1}^n i^3=\left[\frac{n(n+1)}{2}\right]^2"),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetTeoremaDeSumatorias,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetTeoremaDeSumatorias,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(
                        color: kColorFondo,
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"m,\space n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.numerosEnterosPositivos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"c"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.constantes,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
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
