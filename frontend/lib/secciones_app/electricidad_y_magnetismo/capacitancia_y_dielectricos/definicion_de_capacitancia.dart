import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class DefinicionDeCapacitancia extends StatefulWidget {
  const DefinicionDeCapacitancia({Key? key}) : super(key: key);

  @override
  State<DefinicionDeCapacitancia> createState() =>
      _DefinicionDeCapacitanciaState();
}

class _DefinicionDeCapacitanciaState extends State<DefinicionDeCapacitancia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.definicionCapacitancia,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.definicionCapacitancia,
                      widgetName: kWidgetDefinicionDeCapacitancia),
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
                                  .definicionCapacitancia,
                              widgetName: kWidgetDefinicionDeCapacitancia),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .definicionCapacitancia,
                              widgetName: kWidgetDefinicionDeCapacitancia),
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
                    AppLocalizations.of(context)!.cuandoUnCapacitorSeCarga,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"Q \propto V"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"Q = CV"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"C = \frac{Q}{V}"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"[C]_u = \left [ \frac{\text{C}}{\text{V}} \right ] = [F]: Farad"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetDefinicionDeCapacitancia,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetDefinicionDeCapacitancia,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
