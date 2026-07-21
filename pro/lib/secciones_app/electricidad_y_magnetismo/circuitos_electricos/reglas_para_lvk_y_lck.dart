import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ReglasParaLVKyLCK extends StatefulWidget {
  const ReglasParaLVKyLCK({super.key});

  @override
  State<ReglasParaLVKyLCK> createState() => _ReglasParaLVKyLCKState();
}

class _ReglasParaLVKyLCKState extends State<ReglasParaLVKyLCK> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.reglasLVKLCK,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.reglasLVKLCK,
                    widgetName: kWidgetReglasParaLVKyLCK,
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
                            title: AppLocalizations.of(context)!.reglasLVKLCK,
                            widgetName: kWidgetReglasParaLVKyLCK,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(context)!.reglasLVKLCK,
                            widgetName: kWidgetReglasParaLVKyLCK,
                          ),
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
                    AppLocalizations.of(context)!.enRelacionConLVK,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.establecerLaPolaridad,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.enRelacionConLCK,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(
                      context,
                    )!.considerarUnaCorrientePositiva,
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetReglasParaLVKyLCK),
                //Descargar PDF
                DescargarPDF(url: kWidgetReglasParaLVKyLCK),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
