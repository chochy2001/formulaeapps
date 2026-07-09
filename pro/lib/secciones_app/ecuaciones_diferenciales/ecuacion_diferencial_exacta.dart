import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionDiferencialExacta extends StatefulWidget {
  const EcuacionDiferencialExacta({super.key});

  @override
  EcuacionDiferencialExactaState createState() =>
      EcuacionDiferencialExactaState();
}

class EcuacionDiferencialExactaState extends State<EcuacionDiferencialExacta> {
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
                      AppLocalizations.of(context)!.diferencialTotal,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title:
                                AppLocalizations.of(context)!.diferencialTotal,
                            widgetName: kWidgetEcuacionDiferencialExacta),
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
                                        .diferencialTotal,
                                    widgetName:
                                        kWidgetEcuacionDiferencialExacta),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .diferencialTotal,
                                    widgetName:
                                        kWidgetEcuacionDiferencialExacta),
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
                        const Latex(
                            formulaText:
                                r"d[f(x,y)] = \frac{\partial f}{\partial x}dx + \frac{\partial f}{\partial y}dy"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathrm{M}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.coeficientesDeDx,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathrm{N}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.coeficienteDeDy,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\mathrm{M}dx+\mathrm{N}dy = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.esExactaSi,
                        ),
                        const Latex(
                            formulaText:
                                r"\frac{\partial \mathrm{M}}{\partial  y}= \frac{\partial \mathrm{N}}{\partial x}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.paraHacerlaExacta,
                        ),
                        const Latex(
                            formulaText:
                                r"u(x,y)\mathrm{M}(x,y)dx + u(x,y)\mathrm{N}(x,y)dy = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.factorIntegrante,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"u = e^{\int \frac{\mathrm{M}y-\mathrm{N}x}{\mathrm{N}}dx}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"u = e^{\int \frac{\mathrm{N}x-\mathrm{M}y}{\mathrm{M}}dy}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.donde,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\mathrm{M}y = \frac{\partial \mathrm{M}}{\partial y}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\mathrm{N}x = \frac{\partial \mathrm{N}}{\partial x}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.integranDiferenciales,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.variableConstante,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sustituyenIntegral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetEcuacionDiferencialExacta,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetEcuacionDiferencialExacta,
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .elFactorIntegrantePuedeDependerDeCualquieraDeLasDosVariablesEstoSeDeterminaALaHoraDeIntegrarDondeNosDamosCuentaCualEsMasSencilla,
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
