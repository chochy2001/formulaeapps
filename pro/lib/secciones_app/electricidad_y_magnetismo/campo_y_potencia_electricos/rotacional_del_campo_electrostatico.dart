import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class RotacionalDelCampoElectrostatico extends StatefulWidget {
  const RotacionalDelCampoElectrostatico({Key? key}) : super(key: key);

  @override
  State<RotacionalDelCampoElectrostatico> createState() =>
      _RotacionalDelCampoElectrostaticoState();
}

class _RotacionalDelCampoElectrostaticoState
    extends State<RotacionalDelCampoElectrostatico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.rotacionalCampoElectrostatico,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .rotacionalCampoElectrostatico,
                      widgetName: kWidgetRotacionalDelCampoElectrostatico),
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
                                  .rotacionalCampoElectrostatico,
                              widgetName:
                                  kWidgetRotacionalDelCampoElectrostatico),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .rotacionalCampoElectrostatico,
                              widgetName:
                                  kWidgetRotacionalDelCampoElectrostatico),
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
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .rotacionalCampoElectrostaticoCero,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"c_e = \oint \vec{E} \cdot d\vec{l}= \iint \left(\vec{\nabla}\times \vec{E}\right) \cdot d\vec{S} = 0"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"\vec{\nabla}\times \vec{E} = \vec{0}"),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.segundaLeyMaxwell,
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetRotacionalDelCampoElectrostatico,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetRotacionalDelCampoElectrostatico,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
