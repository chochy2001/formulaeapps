import 'package:flutter/material.dart';

import '../../../../constantes/export_constantes.dart';
import '../../../../widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionDePoissonYLaplace extends StatefulWidget {
  const EcuacionDePoissonYLaplace({super.key});

  @override
  State<EcuacionDePoissonYLaplace> createState() =>
      _EcuacionDePoissonYLaplaceState();
}

class _EcuacionDePoissonYLaplaceState extends State<EcuacionDePoissonYLaplace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.ecuacionPoissonLaplace,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.ecuacionPoissonLaplace,
                    widgetName: kWidgetEcuacionDePossionYLaplace,
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
                            )!.ecuacionPoissonLaplace,
                            widgetName: kWidgetEcuacionDePossionYLaplace,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.ecuacionPoissonLaplace,
                            widgetName: kWidgetEcuacionDePossionYLaplace,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40.0),
                  TextoBotonesDelgado(
                    AppLocalizations.of(context)!.leyGaussFormaDiferencial,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"\vec{\nabla} \cdot \vec{E} = \frac{\rho}{\epsilon _0}",
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(
                      context,
                    )!.gradientePotencialCampoElectrico,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{E} = - \vec{\nabla}V"),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.ecuacionPoisson,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"\vec{\nabla} \cdot \vec{\nabla}V = \nabla ^2 V = -\frac{\rho}{\varepsilon _0}",
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.ecuacionLaplace,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"\vec{\nabla} \cdot \vec{\nabla}V = \nabla ^2 V = 0",
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.operadorLaplaciano,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"\vec{\nabla} \cdot \vec{\nabla}\varphi = \nabla ^2 \varphi = \Delta\varphi =",
                  ),
                  const SizedBox(height: 40.0),
                  const Latex(
                    formulaText:
                        r"\frac{\partial ^2 \varphi}{\partial x^2} + \frac{\partial ^2 \varphi}{\partial y^2} + \frac{\partial ^2 \varphi}{\partial z^2}",
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetEcuacionDePossionYLaplace),
                //Descargar PDF
                DescargarPDF(url: kWidgetEcuacionDePossionYLaplace),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
