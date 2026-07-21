import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ConstantesDielectricas extends StatefulWidget {
  const ConstantesDielectricas({super.key});

  @override
  State<ConstantesDielectricas> createState() => _ConstantesDielectricasState();
}

class _ConstantesDielectricasState extends State<ConstantesDielectricas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.constantesDielectricas,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.constantesDielectricas,
                    widgetName: kWidgetConstantesDielectricas,
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
                            )!.constantesDielectricas,
                            widgetName: kWidgetConstantesDielectricas,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.constantesDielectricas,
                            widgetName: kWidgetConstantesDielectricas,
                          ),
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
                    AppLocalizations.of(context)!.elMomentoDipolar,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.polarizacionEnRespuesta,
                  ),
                  const Latex(formulaText: r"\vec{P} \propto \vec{E}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText: r"\vec{P} =  \varepsilon_0 \chi_e \vec{E}",
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(AppLocalizations.of(context)!.laConstante),
                  const Latex(formulaText: r"\chi _e"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.seDenominaSusceptibilidad,
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.permitividadRelativa,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"k_e = 1 + \chi _e"),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.permitividadDelMaterial,
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetConstantesDielectricas),
                //Descargar PDF
                DescargarPDF(url: kWidgetConstantesDielectricas),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
