import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EnergiaAlmacenadaPorUnCapacitor extends StatefulWidget {
  const EnergiaAlmacenadaPorUnCapacitor({super.key});

  @override
  State<EnergiaAlmacenadaPorUnCapacitor> createState() =>
      _EnergiaAlmacenadaPorUnCapacitorState();
}

class _EnergiaAlmacenadaPorUnCapacitorState
    extends State<EnergiaAlmacenadaPorUnCapacitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.energiaAlmacenadaCapacitor,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .energiaAlmacenadaCapacitor,
                      widgetName: kWidgetEnergiaAlmacenadaPorUnCapacitor),
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
                                  .energiaAlmacenadaCapacitor,
                              widgetName:
                                  kWidgetEnergiaAlmacenadaPorUnCapacitor),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .energiaAlmacenadaCapacitor,
                              widgetName:
                                  kWidgetEnergiaAlmacenadaPorUnCapacitor),
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
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.esUnProcesoDeCarga,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.enUnCasoIdeal,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.enUnCasoReal,
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetEnergiaAlmacenadaPorUnCapacitor,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetEnergiaAlmacenadaPorUnCapacitor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
