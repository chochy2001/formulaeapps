import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionDeOhm extends StatefulWidget {
  const EcuacionDeOhm({super.key});

  @override
  State<EcuacionDeOhm> createState() => _EcuacionDeOhmState();
}

class _EcuacionDeOhmState extends State<EcuacionDeOhm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.ecuacionOhm,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.ecuacionOhm,
                      widgetName: kWidgetEcuacionDeOhm),
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
                              title: AppLocalizations.of(context)!.ecuacionOhm,
                              widgetName: kWidgetEcuacionDeOhm),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.ecuacionOhm,
                              widgetName: kWidgetEcuacionDeOhm),
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
                    AppLocalizations.of(context)!.alambreConductor,
                  ),
                  const SizedBox(height: 40.0),
                  const Latex(
                      formulaText: r"i = \iint \vec{J}\cdot d\vec{A} = JA"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"V = - \iint \vec{E}\cdot d\vec{l} = EL"),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyDeOhm,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"|\vec{J}| = \sigma |\vec{E}|"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\frac{i}{A} = \sigma\frac{V}{L}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"V= \rho\frac{L}{A} i"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.resistenciaElectrica,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"R= \rho\frac{L}{A}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"[R]_u = \left[\frac{V}{A}\right] = [\Omega]"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"V = Ri"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[\Omega] = Ohm"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.ecuacionDeOhm,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetEcuacionDeOhm,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetEcuacionDeOhm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
