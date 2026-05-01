import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class IntervalosDeConfianza extends StatefulWidget {
  const IntervalosDeConfianza({Key? key}) : super(key: key);

  @override
  IntervalosDeConfianzaState createState() => IntervalosDeConfianzaState();
}

class IntervalosDeConfianzaState extends State<IntervalosDeConfianza> {
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
                      AppLocalizations.of(context)!.intervalosDeConfianza,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .intervalosDeConfianza,
                            widgetName: kWidgetIntervalosDeConfianza),
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
                                        .intervalosDeConfianza,
                                    widgetName: kWidgetIntervalosDeConfianza),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .intervalosDeConfianza,
                                    widgetName: kWidgetIntervalosDeConfianza),
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
                              .intervaloConfianzaMediaPoblacional,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorLimiteInferior,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"\bar{X}-z\sigma_{\bar{X}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorLimiteSuperior,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"\bar{X}+z\sigma_{\bar{X}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .intervaloConfianzaProporcionPoblacional,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorLimiteInferior,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"\bar{P}-z\sigma_{\bar{P}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorLimiteSuperior,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"\bar{P}+z\sigma_{\bar{P}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetIntervalosDeConfianza,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetIntervalosDeConfianza,
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
                        const Latex(formulaText: r"\bar{X}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.mediaAritmetica,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"z"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.probabilidadOcurrencia,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\sigma_{\bar{X}}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.errorEstandarMedia,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\bar{P}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .promedioMuestralProporcion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\sigma_{\bar{P}}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.errorEstandarProporcion,
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
