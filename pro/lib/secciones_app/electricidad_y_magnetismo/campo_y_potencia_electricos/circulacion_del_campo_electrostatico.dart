import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CirculacionDelCampoElectrostatico extends StatefulWidget {
  const CirculacionDelCampoElectrostatico({super.key});

  @override
  State<CirculacionDelCampoElectrostatico> createState() =>
      _CirculacionDelCampoElectrostaticoState();
}

class _CirculacionDelCampoElectrostaticoState
    extends State<CirculacionDelCampoElectrostatico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.circulacionCampoElectrostatico,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .circulacionCampoElectrostatico,
                      widgetName: kWidgetCirculacionDelCampoElectrostatico),
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
                                  .circulacionCampoElectrostatico,
                              widgetName:
                                  kWidgetCirculacionDelCampoElectrostatico),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .circulacionCampoElectrostatico,
                              widgetName:
                                  kWidgetCirculacionDelCampoElectrostatico),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenCirculacionParaUnaCargaPuntual),
                const Latex(
                    formulaText:
                        r"c_e = \oint \vec{E} \cdot d\vec{l} = \oint k \frac{q}{r^2}\hat{r}\cdot d\vec{l}= kq \oint \frac{dr}{r^2}"),
                const SizedBox(height: 40.0),
                const Latex(
                    formulaText:
                        r"c_e = \lim_{r\rightarrow r'}kq \int_{r}^{r'} \frac{dr}{r^2}=0"),
                const SizedBox(height: 60.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .circulacionCampoElectrostaticoCero,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"c_e = \oint \vec{E}\cdot d\vec{l}=0"),
                const SizedBox(height: 20.0),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetCirculacionDelCampoElectrostatico,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetCirculacionDelCampoElectrostatico,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
