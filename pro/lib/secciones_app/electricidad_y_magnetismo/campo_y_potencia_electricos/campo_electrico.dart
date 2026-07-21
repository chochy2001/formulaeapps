import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CampoElectrico extends StatefulWidget {
  const CampoElectrico({super.key});

  @override
  State<CampoElectrico> createState() => _CampoElectricoState();
}

class _CampoElectricoState extends State<CampoElectrico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.campoElectrico,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.campoElectrico,
                    widgetName: kWidgetCampoElectrico,
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
                            title: AppLocalizations.of(context)!.campoElectrico,
                            widgetName: kWidgetCampoElectrico,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(context)!.campoElectrico,
                            widgetName: kWidgetCampoElectrico,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.campoElectricoFuerzaElectrostatica,
            ),
            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.campoElectricoFuerzaPorUnidadCarga,
            ),
            const SizedBox(height: 30.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.campoElectricoOriginadoCargaPuntual,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\vec{E} = \frac{\vec{F}_{q_0q}}{q_0} = \frac{k\frac{q_0q}{{r_{q_0q}}^2}\hat{r}_{q_0q}}{q_0} = k\frac{q}{{r_{q_0q}}^2}\hat{r}_{q_0q}",
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\vec{E} = k\frac{q}{r^2}\hat{r}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unidadMedidaCampoElectrico,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"[\vec{E}]_u = \left [ \frac{\text{N}}{\text{C}} \right ]",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.principioSuperposicion,
                ),
                const Latex(
                  formulaText:
                      r"\vec{E} = k \sum_{i=1}^{n} \frac{q_i}{r_i^2}\hat{r}_i",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.esquemasCampoElectrico,
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.representacionCampoElectrico,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.tangenteLineasCampo,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.lineasCampoPerpendiculares,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.lineasCampoContinuas,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.lineasCampoComienzanCargas,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.magnitudCampoElectrico,
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetCampoElectrico),
                //Descargar PDF
                DescargarPDF(url: kWidgetCampoElectrico),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
