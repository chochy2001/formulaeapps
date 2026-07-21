import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MedidasDeTendenciaCentralParaDatosNoAgrupados extends StatefulWidget {
  const MedidasDeTendenciaCentralParaDatosNoAgrupados({super.key});

  @override
  MedidasDeTendenciaCentralParaDatosNoAgrupadosState createState() =>
      MedidasDeTendenciaCentralParaDatosNoAgrupadosState();
}

class MedidasDeTendenciaCentralParaDatosNoAgrupadosState
    extends State<MedidasDeTendenciaCentralParaDatosNoAgrupados> {
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
                      )!.tendenciaCentralParaDatosNoAgrupados,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.tendenciaCentralParaDatosNoAgrupados,
                          widgetName:
                              kWidgetMedidasDeTendenciaCentralParaDatosNoAgrupados,
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
                                  )!.tendenciaCentralParaDatosNoAgrupados,
                                  widgetName:
                                      kWidgetMedidasDeTendenciaCentralParaDatosNoAgrupados,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.tendenciaCentralParaDatosNoAgrupados,
                                  widgetName:
                                      kWidgetMedidasDeTendenciaCentralParaDatosNoAgrupados,
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
                        TextoEcuaciones(AppLocalizations.of(context)!.media),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"\bar{X} = \frac{\sum_{i=1}^{n}X_i}{n}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\bar{X}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.esmediaAritmetica,
                        ),
                        const Latex(formulaText: r"x_i"),
                        const SizedBox(height: 10),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.representaValor,
                        ),
                        const Latex(formulaText: r"i, n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.esnumeroTotalDatos,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.mediana),
                        const SizedBox(height: 10),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorCentralColeccion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.impar),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.par),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.modaValorMayorFrecuencia,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.modal),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.bimodal),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.multimodal,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMedidasDeTendenciaCentralParaDatosNoAgrupados,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMedidasDeTendenciaCentralParaDatosNoAgrupados,
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
