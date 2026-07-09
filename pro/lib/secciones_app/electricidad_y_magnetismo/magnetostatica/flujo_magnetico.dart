import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class FlujoMagnetico extends StatefulWidget {
  const FlujoMagnetico({super.key});

  @override
  State<FlujoMagnetico> createState() => _FlujoMagneticoState();
}

class _FlujoMagneticoState extends State<FlujoMagnetico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.flujoMagnetico,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.flujoMagnetico,
                      widgetName: kWidgetFlujoMagnetico),
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
                              title:
                                  AppLocalizations.of(context)!.flujoMagnetico,
                              widgetName: kWidgetFlujoMagnetico),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title:
                                  AppLocalizations.of(context)!.flujoMagnetico,
                              widgetName: kWidgetFlujoMagnetico),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.elFlujoDeCampoMagnetico,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"\Phi = \iint \vec{B} \cdot d\vec{A}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[\Phi_B]_u = [Wb]"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[Wb] = Weber"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .elFlujoDeCampoMagneticoEsUnaMedida,
                  ),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laIntegralDeSuperficieIndica,
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetFlujoMagnetico,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetFlujoMagnetico,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
