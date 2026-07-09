import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionDiferencialDeRectasNoParalelas extends StatefulWidget {
  const EcuacionDiferencialDeRectasNoParalelas({super.key});

  @override
  EcuacionDiferencialDeRectasNoParalelasState createState() =>
      EcuacionDiferencialDeRectasNoParalelasState();
}

class EcuacionDiferencialDeRectasNoParalelasState
    extends State<EcuacionDiferencialDeRectasNoParalelas> {
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
                          .ecuacionDiferencialRectasNoParalelas,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .ecuacionDiferencialRectasNoParalelas,
                            widgetName:
                                kWidgetEcuacionDiferencialDeRectasNoParalelas),
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
                                        .ecuacionDiferencialRectasNoParalelas,
                                    widgetName:
                                        kWidgetEcuacionDiferencialDeRectasNoParalelas),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .ecuacionDiferencialRectasNoParalelas,
                                    widgetName:
                                        kWidgetEcuacionDiferencialDeRectasNoParalelas),
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.puedenTenerLaForma,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(ax+by+c)dx+(fx+gy+h)dy=0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"(ax^2+by^2+c)xdx+(fx^2+gy^2+h)ydy=0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.seSustituyePor,
                        ),
                        const SizedBox(height: 6),
                        const Latex(formulaText: r"x=x'+h"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"y=y'+k"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"dx=dx'"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"dy=dy'"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .tomamosDeCadaCoeficienteLosTerminosDeH,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.kYLaConstante,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.losIgualamosACero,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .posteriormenteSeResuelvePorHomogeneasYAlFinalSeRegresaASusValoresOriginales,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .alResolverPorHomogeneasSeSustituyenLasVariablesPor,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"v = \frac{y'}{x'} \rightarrow y' = vx' \rightarrow dy' = vdx' + x'dv"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"v = \frac{x'}{y'} \rightarrow x' = vy' \rightarrow dx' = vdy' + y'dv"),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetEcuacionDiferencialDeRectasNoParalelas,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetEcuacionDiferencialDeRectasNoParalelas,
                  ),
                  //Notas
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
                        const Latex(formulaText: r"D"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .operadorQueSignificaDerivada,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .ordenDeLaEcuacionSusRaicesSeran,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"r_1,r_2,\cdots ,r_n"),
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
