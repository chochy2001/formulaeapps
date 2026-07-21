import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class TeoremaDeLaCotangente extends StatefulWidget {
  const TeoremaDeLaCotangente({super.key});

  @override
  TeoremaDeLaCotangenteState createState() => TeoremaDeLaCotangenteState();
}

class TeoremaDeLaCotangenteState extends State<TeoremaDeLaCotangente> {
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
                      AppLocalizations.of(context)!.teoremaDeLaCotangente,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.teoremaDeLaCotangente,
                          widgetName: kWidgetTeoremaDeLaCotangente,
                        ),
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
                                  title: AppLocalizations.of(
                                    context,
                                  )!.teoremaDeLaCotangente,
                                  widgetName: kWidgetTeoremaDeLaCotangente,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.teoremaDeLaCotangente,
                                  widgetName: kWidgetTeoremaDeLaCotangente,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cot a \sin b  = \cos b \cos \gamma + \sin \gamma \cot \alpha",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cot a \sin c  = \cos c \cos \beta + \sin \beta \cot \alpha",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cot b \sin a  = \cos a \cos \gamma + \sin \gamma\cot \beta",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cot b \sin c  = \cos c \cos \alpha + \sin \alpha\cot \beta",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cot c \sin a  = \cos a \cos \beta + \sin \beta\cot \gamma",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cot c \sin b  = \cos b \cos \alpha + \sin \alpha\cot \gamma",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const Column(
                    children: [
                      VerPDF(url: kWidgetTeoremaDeLaCotangente),
                      //Descargar PDF
                      DescargarPDF(url: kWidgetTeoremaDeLaCotangente),
                    ],
                  ),

                  //Notas
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(color: kColorFondo, width: 8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a,b,c"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.ladosTrianguloEsferico,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\alpha,\beta,\gamma"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.angulosTrianguloEsferico,
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
