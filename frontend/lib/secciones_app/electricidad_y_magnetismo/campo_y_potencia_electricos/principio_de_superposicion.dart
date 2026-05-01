import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class PrincipioDeSuperposicion extends StatefulWidget {
  const PrincipioDeSuperposicion({Key? key}) : super(key: key);

  @override
  State<PrincipioDeSuperposicion> createState() =>
      _PrincipioDeSuperposicionState();
}

class _PrincipioDeSuperposicionState extends State<PrincipioDeSuperposicion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.principioSuperposicion,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.principioSuperposicion,
                      widgetName: kWidgetPrincipioDeSuperposicion),
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
                                  .principioSuperposicion,
                              widgetName: kWidgetPrincipioDeSuperposicion),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .principioSuperposicion,
                              widgetName: kWidgetPrincipioDeSuperposicion),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            TextoEcuaciones(
              AppLocalizations.of(context)!.principioSuperposicionTexto,
            ),

            const SizedBox(height: 30.0),
            const ZoomImagePersonalizado(
                urlImagen: kUrlImagenPrincipioDeSuperposicion),
            const Column(children: <Widget>[
              Latex(
                  formulaText:
                      r"\vec{F}_1 = \vec{F}_{12} + \vec{F}_{13} + \vec{F}_{14} + \vec{F}_{15}"),
              SizedBox(height: 40.0),
            ]),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetPrincipioDeSuperposicion,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetPrincipioDeSuperposicion,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
