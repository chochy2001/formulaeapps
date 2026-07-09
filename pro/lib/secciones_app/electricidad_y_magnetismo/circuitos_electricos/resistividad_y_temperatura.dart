import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ResistividadYTemperatura extends StatefulWidget {
  const ResistividadYTemperatura({super.key});

  @override
  State<ResistividadYTemperatura> createState() =>
      _ResistividadYTemperaturaState();
}

class _ResistividadYTemperaturaState extends State<ResistividadYTemperatura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.resistividadTemperatura,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.resistividadTemperatura,
                      widgetName: kWidgetResistividadYTemperatura),
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
                                  .resistividadTemperatura,
                              widgetName: kWidgetResistividadYTemperatura),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .resistividadTemperatura,
                              widgetName: kWidgetResistividadYTemperatura),
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
                    AppLocalizations.of(context)!.unMaterialConductor,
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.alIncrementarLaTemperatura,
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laResistividadEnUnConductor,
                  ),
                  const SizedBox(height: 40.0),
                  const Latex(
                      formulaText:
                          r"\rho = \rho_0(1+a(T-T_0)+b(T-T_0)^2+c(T-T_0)^3)"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\rho = \rho_0(1+a(T-T_0)"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"R = R_0(1+\alpha(T-T_0)+\beta(T-T_0)^2+\gamma(T-T_0)^3)"),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetResistividadYTemperatura,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetResistividadYTemperatura,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
