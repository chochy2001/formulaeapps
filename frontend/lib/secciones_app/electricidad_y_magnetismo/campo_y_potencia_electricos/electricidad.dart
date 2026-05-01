import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class Electricidad extends StatefulWidget {
  const Electricidad({Key? key}) : super(key: key);

  @override
  State<Electricidad> createState() => _ElectricidadState();
}

class _ElectricidadState extends State<Electricidad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.electricidad,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.electricidad,
                      widgetName: kWidgetElectricidad),
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
                              title: AppLocalizations.of(context)!.electricidad,
                              widgetName: kWidgetElectricidad),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.electricidad,
                              widgetName: kWidgetElectricidad),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            TextoEcuaciones(
              AppLocalizations.of(context)!.electricidad,
            ),
            const SizedBox(height: 10.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.origenElectricidad,
            ),
            const SizedBox(height: 10.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.conceptoCarga,
            ),

            const SizedBox(height: 35.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.efectosAmbar,
            ),

            const SizedBox(height: 20.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.postulacionSustancia,
            ),

            const SizedBox(height: 20.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.tiposSustancia,
            ),

            const SizedBox(height: 20.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.descubrimientoElectron,
            ),

            const SizedBox(height: 20.0),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetElectricidad,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetElectricidad,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
