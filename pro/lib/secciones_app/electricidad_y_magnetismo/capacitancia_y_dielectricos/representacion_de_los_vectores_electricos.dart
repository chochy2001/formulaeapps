import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class RepresentacionDeLosVectoresElectricos extends StatefulWidget {
  const RepresentacionDeLosVectoresElectricos({Key? key}) : super(key: key);

  @override
  State<RepresentacionDeLosVectoresElectricos> createState() =>
      _RepresentacionDeLosVectoresElectricosState();
}

class _RepresentacionDeLosVectoresElectricosState
    extends State<RepresentacionDeLosVectoresElectricos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.representacionVectoresElectricos,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .representacionVectoresElectricos,
                      widgetName: kWidgetRepresentacionDeLosVectoresElectricos),
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
                                  .representacionVectoresElectricos,
                              widgetName:
                                  kWidgetRepresentacionDeLosVectoresElectricos),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .representacionVectoresElectricos,
                              widgetName:
                                  kWidgetRepresentacionDeLosVectoresElectricos),
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
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context,
                            kImagenRepresentacionDeLosVectoresElectricos) ??
                        kUrlImagenRepresentacionDeLosVectoresElectricos),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.capacitorDePlacas,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"C = \frac{Q}{V}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"E = \frac{Q}{\varepsilon A}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"V = - \int_B^A \vec{E} \cdot d\vec{l} = Ed"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"C = \frac{A\varepsilon}{d} = k_e \frac{A\varepsilon_0}{d}"),
                const SizedBox(height: 30.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetRepresentacionDeLosVectoresElectricos,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetRepresentacionDeLosVectoresElectricos,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
