import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyDeCoulomb extends StatefulWidget {
  const LeyDeCoulomb({Key? key}) : super(key: key);

  @override
  State<LeyDeCoulomb> createState() => _LeyDeCoulombState();
}

class _LeyDeCoulombState extends State<LeyDeCoulomb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.leyCoulomb,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.leyCoulomb,
                      widgetName: kWidgetLeyDeCoulomb),
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
                              title: AppLocalizations.of(context)!.leyCoulomb,
                              widgetName: kWidgetLeyDeCoulomb),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.leyCoulomb,
                              widgetName: kWidgetLeyDeCoulomb),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.leyCoulombTexto,
            ),

            const SizedBox(height: 30.0),
            const ZoomImagePersonalizado(urlImagen: kUrlImagenCargasPuntuales),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unidadFuerza,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"[\vec{F}]_u = [N]"),
                const SizedBox(height: 40.0),
                const Latex(
                    formulaText:
                        r"\vec{F}_{12} = k \frac{q_1 q_2}{{r_{12}}^2}\hat{r}_{12}"),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.constanteCoulomb,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"k = \frac{1}{4\pi\epsilon_0} = 8.99 \times 10^9 \left[\frac{N \cdot m^2}{C^2}\right]"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.permitividadVacio,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\epsilon_0 = 8.854 \times 10^{-12} \left[\frac{C^2}{N\cdot m^2}\right]"),
                const SizedBox(height: 40.0),
              ],
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetLeyDeCoulomb,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetLeyDeCoulomb,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
