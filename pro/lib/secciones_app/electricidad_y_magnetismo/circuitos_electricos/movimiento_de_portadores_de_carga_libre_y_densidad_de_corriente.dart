import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MovimientoDePortadoresDeCargaLibreYDensidadDeCorriente
    extends StatefulWidget {
  const MovimientoDePortadoresDeCargaLibreYDensidadDeCorriente({super.key});

  @override
  State<MovimientoDePortadoresDeCargaLibreYDensidadDeCorriente> createState() =>
      _MovimientoDePortadoresDeCargaLibreYDensidadDeCorrienteState();
}

class _MovimientoDePortadoresDeCargaLibreYDensidadDeCorrienteState
    extends State<MovimientoDePortadoresDeCargaLibreYDensidadDeCorriente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!
                    .movimientoPortadoresCargaLibreDensidadCorriente,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .movimientoPortadoresCargaLibreDensidadCorriente,
                      widgetName:
                          kWidgetMovimientoDePortadoresDeCargaLibreYDensidadDeCorriente),
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
                                  .movimientoPortadoresCargaLibreDensidadCorriente,
                              widgetName:
                                  kWidgetMovimientoDePortadoresDeCargaLibreYDensidadDeCorriente),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .movimientoPortadoresCargaLibreDensidadCorriente,
                              widgetName:
                                  kWidgetMovimientoDePortadoresDeCargaLibreYDensidadDeCorriente),
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
                    AppLocalizations.of(context)!.cargaDelPortador,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{F} = q\vec{E}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .movilidadDeLosPortadoresDeCargaLibres,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\vec{V}_p \propto \vec{E} \space\space\space\space\space\space\space\space \vec{V}_p = \mu \vec{E}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .flujoDelCampoVectorialDeVelocidad,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"\Phi = \iint \vec{V}_p \cdot d\vec{A}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .flujoDeCargaNetaPorUnidadDeTiempo,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\Phi = \iint \rho_{v'}\vec{V}_p \cdot d\vec{A}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\rho_{v'} = n_{v'}q"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\Phi = \iint n_{v'}q\vec{V}_p \cdot d\vec{A}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.densidadDeCorriente,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{J} = n_{v'}q\vec{V}_p"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"[\vec{J}]_u = \left[\frac{1}{m^3}C\frac{m}{s}\right] = \left[\frac{A}{m^2}\right]"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[A] = Ampere"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url:
                      kWidgetMovimientoDePortadoresDeCargaLibreYDensidadDeCorriente,
                ),
                //Descargar PDF
                DescargarPDF(
                  url:
                      kWidgetMovimientoDePortadoresDeCargaLibreYDensidadDeCorriente,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
