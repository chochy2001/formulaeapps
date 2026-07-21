import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class Amortizacion extends StatefulWidget {
  const Amortizacion({super.key});

  @override
  AmortizacionState createState() => AmortizacionState();
}

class AmortizacionState extends State<Amortizacion> {
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
                      AppLocalizations.of(context)!.amortizacion,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(context)!.amortizacion,
                          widgetName: kWidgetAmortizacion,
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
                                  )!.amortizacion,
                                  widgetName: kWidgetAmortizacion,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.amortizacion,
                                  widgetName: kWidgetAmortizacion,
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
                          AppLocalizations.of(
                            context,
                          )!.rentaInteresAmortizacion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.amortizacion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A = \frac{C}{n}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.interesesSaldosInsolutos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"R=\left(\frac{C}{2n}\right)[(n+1)i+2]",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetAmortizacion),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetAmortizacion),
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
                        ZoomPersonalizado(
                          child: Column(
                            children: [
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"A"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.amortizacion,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"i"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.tasaInteresSimple,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"n"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.numeroPeriodos,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"R"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.renta,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"C"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.capital,
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
