import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MotorDeCorrienteDirecta extends StatefulWidget {
  const MotorDeCorrienteDirecta({Key? key}) : super(key: key);

  @override
  State<MotorDeCorrienteDirecta> createState() =>
      _MotorDeCorrienteDirectaState();
}

class _MotorDeCorrienteDirectaState extends State<MotorDeCorrienteDirecta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.motorDeCorrienteDirecta,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.motorDeCorrienteDirecta,
                      widgetName: kWidgetMotorDeCorrienteDirecta),
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
                                  .motorDeCorrienteDirecta,
                              widgetName: kWidgetMotorDeCorrienteDirecta),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .motorDeCorrienteDirecta,
                              widgetName: kWidgetMotorDeCorrienteDirecta),
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
                    urlImagen: getImageUrlById(
                            context, kImagenMotorDeCorrienteDirecta) ??
                        kUrlImagenMotorDeCorrienteDirecta),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.motorMaquina,
                ),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenMotorDeCorrienteDirecta1) ??
                        kUrlImagenMotorDeCorrienteDirecta1),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"W= - \vec{p}_m \cdot \vec{B}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetMotorDeCorrienteDirecta,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetMotorDeCorrienteDirecta,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
