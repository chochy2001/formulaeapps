import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class RigidezDielectrica extends StatefulWidget {
  const RigidezDielectrica({super.key});

  @override
  State<RigidezDielectrica> createState() => _RigidezDielectricaState();
}

class _RigidezDielectricaState extends State<RigidezDielectrica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.rigidezDielectrica,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.rigidezDielectrica,
                    widgetName: kWidgetRigidezDielectrica,
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
                            title: AppLocalizations.of(
                              context,
                            )!.rigidezDielectrica,
                            widgetName: kWidgetRigidezDielectrica,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.rigidezDielectrica,
                            widgetName: kWidgetRigidezDielectrica,
                          ),
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
                  AppLocalizations.of(context)!.paraUnMaterialDado,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"E \propto \sigma _i"),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"E_r = \frac{V_{max}}{d}"),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenRigidezDielectrica,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elDesplazamientoDeCarga,
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetRigidezDielectrica),
                //Descargar PDF
                DescargarPDF(url: kWidgetRigidezDielectrica),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
