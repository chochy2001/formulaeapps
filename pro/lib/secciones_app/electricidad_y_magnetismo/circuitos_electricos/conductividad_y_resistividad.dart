import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ConductividadYResistividad extends StatefulWidget {
  const ConductividadYResistividad({super.key});

  @override
  State<ConductividadYResistividad> createState() =>
      _ConductividadYResistividadState();
}

class _ConductividadYResistividadState
    extends State<ConductividadYResistividad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.conductividadResistividad,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .conductividadResistividad,
                      widgetName: kWidgetConductividadyResistividad),
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
                                  .conductividadResistividad,
                              widgetName: kWidgetConductividadyResistividad),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .conductividadResistividad,
                              widgetName: kWidgetConductividadyResistividad),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenConductividadYResistividad),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .velocidadDeLosPortadoresDeCargaLibre,
                ),
                const Latex(formulaText: r"\vec{V}_p = \mu \vec{E}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.densidadDeCorriente,
                ),
                const Latex(formulaText: r"\vec{j} = n_{v'}q\vec{V}_p"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{j} n_{v'} q\vec{V}_p = n_{v'}q \mu \vec{E}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conductividadElectrica,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\sigma = n_{v'}q\mu"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"[\sigma]_u = \left[ \frac{1}{m^3}\cdot \frac{Cm}{Ns}\right] = \left[\frac{1}{\Omega m}\right]"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .laConductividadElectricaEsUnaConstante,
                ),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetConductividadyResistividad,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetConductividadyResistividad,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
