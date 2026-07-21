import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MedidasDeTendenciaCentralParaDatosAgrupados extends StatefulWidget {
  const MedidasDeTendenciaCentralParaDatosAgrupados({super.key});

  @override
  MedidasDeTendenciaCentralParaDatosAgrupadosState createState() =>
      MedidasDeTendenciaCentralParaDatosAgrupadosState();
}

class MedidasDeTendenciaCentralParaDatosAgrupadosState
    extends State<MedidasDeTendenciaCentralParaDatosAgrupados> {
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
                      )!.tendenciaCentralParaDatosAgrupados,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.tendenciaCentralParaDatosAgrupados,
                          widgetName:
                              kWidgetMedidasDeTendenciaCentralParaDatosAgrupados,
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
                                  )!.tendenciaCentralParaDatosAgrupados,
                                  widgetName:
                                      kWidgetMedidasDeTendenciaCentralParaDatosAgrupados,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.tendenciaCentralParaDatosAgrupados,
                                  widgetName:
                                      kWidgetMedidasDeTendenciaCentralParaDatosAgrupados,
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.marcaAmplitudClase,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"MC = \frac{L_i+L_s}{2}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"c = L_{iB}-L_{iA}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.media),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\bar{X} = \frac{\sum_{i=1}^{n}f_iMC_i}{n}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.mediana),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"M_d = LIR_{M_d}+\frac{\frac{n}{2}-fa_{antM_d}}{f_{M_d}}\cdot c",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.moda),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"M_o = LIR_{M_o}+\frac{(f_{M_o}-f_1)}{(f_{M_o}-f_1)+(f_{M_o}-f_2)}\cdot c",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMedidasDeTendenciaCentralParaDatosAgrupados,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMedidasDeTendenciaCentralParaDatosAgrupados,
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
                        const Latex(formulaText: r"c"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.amplitudClase,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.numeroTotalDatos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\bar{X}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.mediaAritmetica,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"M_d"),
                        TextoEcuaciones(AppLocalizations.of(context)!.mediana),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"M_o"),
                        TextoEcuaciones(AppLocalizations.of(context)!.moda),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"MC"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.marcaClase,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"MC_i"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.marcaClaseIntervaloi,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"F_{M_d}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.frecuenciaClaseMediana,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"f_1"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.frecuenciaAnteriorClaseModal,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"f_i"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.frecuenciaIntervaloi,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"f_2"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.frecuenciaPosteriorClaseModal,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"f_{M_o}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.frecuenciaClaseModal,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"fa_{antM_d}"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.frecuenciaAcumuladaClaseAnteriorMediana,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L_i"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.limiteInferior,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L_s"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.limiteSuperior,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L_{iB}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.limiteInferiorB,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L_{iA}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.limiteInferiorA,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"LIR_{M_d}"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.limiteInferiorRealClaseMediana,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"LIR_{M_o}"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.limiteInferiorRealClaseModal,
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
