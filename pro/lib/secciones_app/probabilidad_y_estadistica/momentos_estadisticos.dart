import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MomentosEstadisticos extends StatefulWidget {
  const MomentosEstadisticos({Key? key}) : super(key: key);

  @override
  MomentosEstadisticosState createState() => MomentosEstadisticosState();
}

class MomentosEstadisticosState extends State<MomentosEstadisticos> {
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
                      AppLocalizations.of(context)!.momentosEstadisticos,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .momentosEstadisticos,
                            widgetName: kWidgetMomentosEstadisticos),
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
                                        .momentosEstadisticos,
                                    widgetName: kWidgetMomentosEstadisticos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .momentosEstadisticos,
                                    widgetName: kWidgetMomentosEstadisticos),
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
                          AppLocalizations.of(context)!
                              .diferenciaMarcaClaseMedia,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"Y = MC -\bar{X}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .momentoEstadisticoPrimerGrado,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"ME_1 = \frac{\sum_{i=1}^{n}f_i\cdot Y_i}{n} = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .momentoEstadisticoSegundoGrado,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"ME_2 = \frac{\sum_{i=1}^{n}f_i\cdot Y_i^2}{n} = S^2"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .momentoEstadisticoTercerGrado,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"ME_3 = \frac{\sum_{i=1}^{n}f_i\cdot Y_i^3}{n}"),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"k_3 = \frac{ME_3}{S^3}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .momentoEstadisticoCuartoGrado,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"ME_4 = \frac{\sum_{i=1}^{n}f_i\cdot Y_i^4}{n} = 0"),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"k_4 = \frac{ME_4}{S^4}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMomentosEstadisticos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMomentosEstadisticos,
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
                        ZoomPersonalizado(
                          child: Column(
                            children: [
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"MC"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.marcaClase,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"\bar{X}"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.mediaAritmetica,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"ME"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .momentoEstadistico,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"f_i"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .frecuenciaIntervaloi,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"n"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.numeroTotalDatos,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"S"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .desviacionEstandar,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"Y_i"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .diferenciaMarcaClaseMedida,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"k_3"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .coeficienteAsimetria,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_3 > 0 "),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .curvaAsimetriaDerecha,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_3 = 0 "),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .curvaDistribucionSimetrica,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_3 < 0"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .curvaAsimetriaIzquierda,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"k_4 "),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .coeficienteApuntamiento,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_4 -3 >0"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.curvaLeptocurtica,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_4 -3 =0"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.curvaMesocurtica,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_4 -3 <0 "),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.curvaPlatocurtica,
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
          ],
        ),
      ),
    );
  }
}
