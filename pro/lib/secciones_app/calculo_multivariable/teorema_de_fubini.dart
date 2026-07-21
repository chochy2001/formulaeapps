import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class TeoremaDeFubini extends StatefulWidget {
  const TeoremaDeFubini({super.key});

  @override
  TeoremaDeFubiniState createState() => TeoremaDeFubiniState();
}

class TeoremaDeFubiniState extends State<TeoremaDeFubini> {
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
                AppLocalizations.of(context)!.teoremaFubini,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.teoremaFubini,
                    widgetName: kWidgetTeoremaDeFubini,
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
                            title: AppLocalizations.of(context)!.teoremaFubini,
                            widgetName: kWidgetTeoremaDeFubini,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(context)!.teoremaFubini,
                            widgetName: kWidgetTeoremaDeFubini,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            const ZoomPersonalizado(
              child: Column(
                children: [
                  SizedBox(height: kEspacioEntreBotones),
                  SizedBox(height: kEspacioEntreBotones),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\iint_{|a,b|\times |c,d|}f(x,y)dxdy"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"= \int_a^b\left(\int_c^d f(x,y)dy\right)dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"= \int_c^d\left(\int_a^b f(x,y)dx\right)dy",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  SizedBox(height: kEspacioEntreBotones),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetTeoremaDeFubini),
                //Descargar PDF
                DescargarPDF(url: kWidgetTeoremaDeFubini),
              ],
            ),

            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
