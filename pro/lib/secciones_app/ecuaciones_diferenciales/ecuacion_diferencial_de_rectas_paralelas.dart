import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionDiferencialDeRectasParalelas extends StatefulWidget {
  const EcuacionDiferencialDeRectasParalelas({super.key});

  @override
  EcuacionDiferencialDeRectasParalelasState createState() =>
      EcuacionDiferencialDeRectasParalelasState();
}

class EcuacionDiferencialDeRectasParalelasState
    extends State<EcuacionDiferencialDeRectasParalelas> {
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
                      )!.ecuacionDiferencialRectasParalelas,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.ecuacionDiferencialRectasParalelas,
                          widgetName:
                              kWidgetEcuacionDiferencialDeRectasParalelas,
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
                                  )!.ecuacionDiferencialRectasParalelas,
                                  widgetName:
                                      kWidgetEcuacionDiferencialDeRectasParalelas,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.ecuacionDiferencialRectasParalelas,
                                  widgetName:
                                      kWidgetEcuacionDiferencialDeRectasParalelas,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.puedenTenerLaForma,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"1. \space (ax+by+c)dx+(ax+by+f)dy=0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"2. \space (ax+by+c)dx+(nax+mby+j)dy=0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"3. \space(ax^2+by^2+c)xdx+(ax^2+by^2+f)ydy=0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"4. \space(ax^2+by^2+c)xdx+(nax^2+mby^2+j)ydy=0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"5. \space(ax+by+c)dx+kdy = 0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"6. \space(ax^2+by^2+c)xdx+kdy = 0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.yaHechaLaSustitucionDeLasVariablesAsiComoDelDiferencial,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.seResuelvePorVariablesSeparablesYAlFinalSeRegresanSusValoresOriginales,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetEcuacionDiferencialDeRectasParalelas,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetEcuacionDiferencialDeRectasParalelas,
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
                        const Latex(formulaText: r"k "),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.constanteCualquiera,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\mathsf{Ec.} \space 3, 4\space  \mathsf{y}\space 6",
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.seHacenDeLaFormaDeLasRestantesUtilizandolaSustitucion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"r = x^2, w=y^2,dr = 2xdx \space \mathrm{y} \space dw = 2ydy",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.seUsaLaSustitucionDelDiferencialEnElCoeficienteMasSencillo,
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
