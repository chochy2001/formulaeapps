import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyDeOhm extends StatefulWidget {
  const LeyDeOhm({Key? key}) : super(key: key);

  @override
  State<LeyDeOhm> createState() => _LeyDeOhmState();
}

class _LeyDeOhmState extends State<LeyDeOhm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.leyOhm,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.leyOhm,
                      widgetName: kWidgetLeyDeOhm),
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
                              title: AppLocalizations.of(context)!.leyOhm,
                              widgetName: kWidgetLeyDeOhm),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.leyOhm,
                              widgetName: kWidgetLeyDeOhm),
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
                    AppLocalizations.of(context)!.resistividadElectrica,
                  ),
                  const SizedBox(height: 40.0),
                  const Latex(formulaText: r"\rho = \frac{1}{\sigma}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[\rho]_u = [\Omega m]"),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .resistividadElectricaConstante,
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .densisdadCorrienteCampoElectrico,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{j} n_{v'}q\mu \vec{E}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\sigma = n_{v'}q\mu"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{j} = \sigma \vec{E}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{E} = \rho \vec{j}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.formaVectorialLeyDeOhm,
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyDeOhmDensidad,
                  ),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetLeyDeOhm,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetLeyDeOhm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
