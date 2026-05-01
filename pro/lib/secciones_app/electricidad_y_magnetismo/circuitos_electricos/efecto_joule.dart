import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EfectoJoule extends StatefulWidget {
  const EfectoJoule({Key? key}) : super(key: key);

  @override
  State<EfectoJoule> createState() => _EfectoJouleState();
}

class _EfectoJouleState extends State<EfectoJoule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.efectoJoule,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.efectoJoule,
                    widgetName: kWidgetEfectoJoule,
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
                              title: AppLocalizations.of(context)!.efectoJoule,
                              widgetName: kWidgetEfectoJoule),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.efectoJoule,
                              widgetName: kWidgetEfectoJoule),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!.desplazamientoDeElectrones,
                ),
                const SizedBox(height: 40.0),
                const Latex(formulaText: r"V= \frac{U}{q}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"P = \frac{U}{t} = Vi"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"P = Ri ^2 = \frac{V^2}{R}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"[P]_u = [W]: Watt"),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(urlImagen: kUrlImagenEfectoJoule),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeJoule,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.resistor,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(urlImagen: kUrlImagenEfectoJoule2),
                const ZoomImagePersonalizado(urlImagen: kUrlImagenEfectoJoule1),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.resistorPuro,
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetEfectoJoule,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetEfectoJoule,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
