import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LongitudDeArco extends StatefulWidget {
  const LongitudDeArco({Key? key}) : super(key: key);

  @override
  LongitudDeArcoState createState() => LongitudDeArcoState();
}

class LongitudDeArcoState extends State<LongitudDeArco> {
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
                AppLocalizations.of(context)!.longitudArco,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.longitudArco,
                      widgetName: kWidgetLongitudDeArco),
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
                              title: AppLocalizations.of(context)!.longitudArco,
                              widgetName: kWidgetLongitudDeArco),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.longitudArco,
                              widgetName: kWidgetLongitudDeArco),
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
                    AppLocalizations.of(context)!.curvaDeDosDimensiones,
                  ),
                  const Latex(
                      formulaText:
                          r"L = \int_a^b \sqrt{|f'(t)|^2 + |g'(t)|^2}dt"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.curvaDeTresDimensiones,
                  ),
                  const SizedBox(height: 10),
                  const Latex(
                      formulaText:
                          r"L = \int_a^b \sqrt{|f'(t)|^2 + |g'(t)|^2 +|h'(t)|^2}dt"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetLongitudDeArco,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetLongitudDeArco,
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
