import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class AreaDeUnaSuperficieDeRevolucion extends StatefulWidget {
  const AreaDeUnaSuperficieDeRevolucion({super.key});

  @override
  AreaDeUnaSuperficieDeRevolucionState createState() =>
      AreaDeUnaSuperficieDeRevolucionState();
}

class AreaDeUnaSuperficieDeRevolucionState
    extends State<AreaDeUnaSuperficieDeRevolucion> {
  bool seleccionadoMostrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.areaSuperficieRevolucion,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .areaSuperficieRevolucion,
                      widgetName: kWidgetAreaDeUnaSuperficieDeRevolucion),
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
                                  .areaSuperficieRevolucion,
                              widgetName:
                                  kWidgetAreaDeUnaSuperficieDeRevolucion),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .areaSuperficieRevolucion,
                              widgetName:
                                  kWidgetAreaDeUnaSuperficieDeRevolucion),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 20.0,
            ),
            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.alrededordelejex,
                  ),
                  const Latex(
                      formulaText:
                          r"A= 2 \pi \int_{a}^b y\sqrt{1+\left( \frac{dy}{dx} \right)^2}dx"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.alrededordelejey,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"A= 2 \pi \int_{a}^b x\sqrt{1+\left( \frac{dx}{dy} \right)^2}dy"),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetAreaDeUnaSuperficieDeRevolucion,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetAreaDeUnaSuperficieDeRevolucion,
                ),
              ],
            ),

            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
