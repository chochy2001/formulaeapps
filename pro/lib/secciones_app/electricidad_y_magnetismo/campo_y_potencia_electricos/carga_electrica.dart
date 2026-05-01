import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CargaElectrica extends StatefulWidget {
  const CargaElectrica({Key? key}) : super(key: key);

  @override
  State<CargaElectrica> createState() => _CargaElectricaState();
}

class _CargaElectricaState extends State<CargaElectrica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.cargaElectrica,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.cargaElectrica,
                      widgetName: kWidgetCargaElectrica),
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
                              title:
                                  AppLocalizations.of(context)!.cargaElectrica,
                              widgetName: kWidgetCargaElectrica),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title:
                                  AppLocalizations.of(context)!.cargaElectrica,
                              widgetName: kWidgetCargaElectrica),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.convencionFranklin,
            ),
            const SizedBox(height: 10.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.procesoCarga,
            ),

            const SizedBox(height: 10.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.dosTiposCarga,
            ),

            const SizedBox(height: 30.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.definicionCarga,
            ),
            TextoEcuaciones(
              AppLocalizations.of(context)!.cargaElectrostatica,
            ),

            const SizedBox(height: 10.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.propiedadCarga,
            ),

            const SizedBox(height: 30.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.produccionCarga,
            ),
            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.principioConservacion,
            ),

            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.transferenciaCarga,
            ),

            const SizedBox(height: 30.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.procesosTransferencia,
            ),
            const SizedBox(height: 15.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.procesoCarga,
            ),

            const SizedBox(height: 15.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.procesosDescarga,
            ),

            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.clasificacionMateriales,
            ),
            const SizedBox(height: 10.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.materialConductor,
            ),

            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.materialDielectrico,
            ),

            const SizedBox(height: 20.0),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetCargaElectrica,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetCargaElectrica,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
