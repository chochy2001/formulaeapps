import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class SimetriaImpar extends StatefulWidget {
  const SimetriaImpar({Key? key}) : super(key: key);

  @override
  SimetriaImparState createState() => SimetriaImparState();
}

class SimetriaImparState extends State<SimetriaImpar> {
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
                      AppLocalizations.of(context)!.simetriaImpar,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.simetriaImpar,
                            widgetName: kWidgetSimetriaImpar),
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
                                        .simetriaImpar,
                                    widgetName: kWidgetSimetriaImpar),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .simetriaImpar,
                                    widgetName: kWidgetSimetriaImpar),
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
                          AppLocalizations.of(context)!.simetriaImpar,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"f(t) = -f(-t)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"f(t) = \sum_{n=1}^{\infty} b_{n}\sin(n\omega_0t)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .coeficientesSerieFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"a_0 = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a_n = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"b_n = \frac{4}{T}\int_{0}^{T/2}f(t)\sin(n\omega_0t)dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSimetriaImpar,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSimetriaImpar,
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
