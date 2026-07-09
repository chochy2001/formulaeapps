import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class IntegralEnCoordenadasCilindricas extends StatefulWidget {
  const IntegralEnCoordenadasCilindricas({super.key});

  @override
  IntegralEnCoordenadasCilindricasState createState() =>
      IntegralEnCoordenadasCilindricasState();
}

class IntegralEnCoordenadasCilindricasState
    extends State<IntegralEnCoordenadasCilindricas> {
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
                AppLocalizations.of(context)!.integralCoordenadasCilindricas,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .integralCoordenadasCilindricas,
                      widgetName: kWidgetIntegralEnCoordenasCilindricas),
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
                                  .integralCoordenadasCilindricas,
                              widgetName:
                                  kWidgetIntegralEnCoordenasCilindricas),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .integralCoordenadasCilindricas,
                              widgetName:
                                  kWidgetIntegralEnCoordenasCilindricas),
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
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .coordenadasCartesianaACilindricas,
                  ),
                  const Latex(
                      formulaText:
                          r"\int_{D_{xyz}}\iint F(x,y,z)dx\thinspace dy\thinspace dz=\int_0^r\int_0^{2\pi}\int_0^z G(r,\phi,z)r\thinspace dr\thinspace d\phi\thinspace dz"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .coordenadasCartesianaAEsfericas,
                  ),
                  const Latex(
                      formulaText:
                          r"\int_{D_{xyz}}\iint F(x,y,z)dx\thinspace dy\thinspace dz=\int_0^r\int_{\frac{-\pi}{2}}^{\frac{\pi}{2}}\int_0^{2\pi} G(r,\theta,\phi)r^2\thinspace \sin\theta\space dr d\theta d\phi"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetIntegralEnCoordenasCilindricas,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetIntegralEnCoordenasCilindricas,
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
