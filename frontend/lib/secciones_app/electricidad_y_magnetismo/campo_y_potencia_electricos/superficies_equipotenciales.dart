import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class SuperficiesEquipotenciales extends StatefulWidget {
  const SuperficiesEquipotenciales({Key? key}) : super(key: key);

  @override
  State<SuperficiesEquipotenciales> createState() =>
      _SuperficiesEquipotencialesState();
}

class _SuperficiesEquipotencialesState
    extends State<SuperficiesEquipotenciales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.superficiesEquipotenciales,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .superficiesEquipotenciales,
                      widgetName: kWidgetSuperficiesEquipotenciales),
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
                                  .superficiesEquipotenciales,
                              widgetName: kWidgetSuperficiesEquipotenciales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .superficiesEquipotenciales,
                              widgetName: kWidgetSuperficiesEquipotenciales),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.teoremaUnicidad,
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .superficiesConductorasCargadasParalelas,
                ),
                const ZoomImagePersonalizado(
                    urlImagen:
                        kUrlImagenSuperficiesConductorasCargadasParalelas),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.ecuacionLaplace,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\nabla ^2 V = \frac{\partial ^2 V}{\partial y^2} = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V(y) = A_y + B"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.condicionesFrontera,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V(0) = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V(d) = V_0"),
                const SizedBox(height: 40.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenSuperficiesEquipotenciales),
                const Latex(formulaText: r"V(y) = \frac{V_0}{d}y"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.superficieEquipotencial,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.equipotencialCumple,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_{AB} = V_A = V_B = 0"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetSuperficiesEquipotenciales,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetSuperficiesEquipotenciales,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
