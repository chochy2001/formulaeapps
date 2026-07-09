import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyDeInduccionDeFaradayEnergiaEnUnInductor extends StatefulWidget {
  const LeyDeInduccionDeFaradayEnergiaEnUnInductor({super.key});

  @override
  State<LeyDeInduccionDeFaradayEnergiaEnUnInductor> createState() =>
      _LeyDeInduccionDeFaradayEnergiaEnUnInductorState();
}

class _LeyDeInduccionDeFaradayEnergiaEnUnInductorState
    extends State<LeyDeInduccionDeFaradayEnergiaEnUnInductor> {
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
                    .leyDeInduccionDeFaradayYEnergisEnUnInductor,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .leyDeInduccionDeFaradayYEnergisEnUnInductor,
                      widgetName: kWidgetLeyDeFaradayYEnergiaEnUnInductor),
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
                                  .leyDeInduccionDeFaradayYEnergisEnUnInductor,
                              widgetName:
                                  kWidgetLeyDeFaradayYEnergiaEnUnInductor),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyDeInduccionDeFaradayYEnergisEnUnInductor,
                              widgetName:
                                  kWidgetLeyDeFaradayYEnergiaEnUnInductor),
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
                    AppLocalizations.of(context)!.unInductorAlmacena,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.deAcuerdoConLaLeyDeInduccion,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"\varepsilon_i = -\frac{d}{dt}\lambda"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\varepsilon_i = -L\frac{d}{dt}I"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laCorrienteAsociadaALaFEM,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"_BW_A = qV_{AB}"),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"dw = \varepsilon_i dq"),
                  const SizedBox(height: 10.0),
                  const Latex(
                      formulaText:
                          r"=L\frac{dl}{dt}dq=L\frac{dq}{dt}dI = LIdI"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"U = W = \frac{1}{2}LI^2 = \frac{1}{2}LI^2\frac{1}{2}\lambda I"),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"[U]_u = [J]"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetLeyDeFaradayYEnergiaEnUnInductor,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetLeyDeFaradayYEnergiaEnUnInductor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
