import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionDiferencialSeparable extends StatefulWidget {
  const EcuacionDiferencialSeparable({super.key});

  @override
  EcuacionDiferencialSeparableState createState() =>
      EcuacionDiferencialSeparableState();
}

class EcuacionDiferencialSeparableState
    extends State<EcuacionDiferencialSeparable> {
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
                      AppLocalizations.of(
                        context,
                      )!.ecuacionDiferencialSeparable,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.ecuacionDiferencialSeparable,
                          widgetName: kWidgetEcuacionDiferencialSeparable,
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
                                  )!.ecuacionDiferencialSeparable,
                                  widgetName:
                                      kWidgetEcuacionDiferencialSeparable,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.ecuacionDiferencialSeparable,
                                  widgetName:
                                      kWidgetEcuacionDiferencialSeparable,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"[f(x)g(y)]dx+[h(x)k(y)]dy = 0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.factorIntegrante,
                        ),
                        const Latex(formulaText: r"\frac{1}{g(y)h(x)}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.variablesSeparadas,
                        ),
                        const Latex(
                          formulaText:
                              r"\frac{f(x)}{h(x)}dx+\frac{k(y)}{g(y)}dy = 0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.seIntegraDeAmbosLadosParaObtenerLaSolucionGeneral,
                        ),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetEcuacionDiferencialSeparable),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetEcuacionDiferencialSeparable),
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
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.elFactorIntegranteEsIgualAlInversoDeLaMultiplicacionDeLosFactoresQueNoContienenLaVariableDelDiferencialSeMultiplicaPorAmbosLados,
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
