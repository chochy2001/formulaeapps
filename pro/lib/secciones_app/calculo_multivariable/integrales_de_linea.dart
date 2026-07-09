import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class IntegralesDeLinea extends StatefulWidget {
  const IntegralesDeLinea({super.key});

  @override
  IntegralesDeLineaState createState() => IntegralesDeLineaState();
}

class IntegralesDeLineaState extends State<IntegralesDeLinea> {
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
                AppLocalizations.of(context)!.integralesLinea,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.integralesLinea,
                      widgetName: kWidgetIntegralesDeLinea),
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
                                  AppLocalizations.of(context)!.integralesLinea,
                              widgetName: kWidgetIntegralesDeLinea),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title:
                                  AppLocalizations.of(context)!.integralesLinea,
                              widgetName: kWidgetIntegralesDeLinea),
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
                    AppLocalizations.of(context)!.deCamposEscalares,
                  ),
                  const Latex(
                      formulaText:
                          r"\int_C F(s)ds= \int_{t_P}^{t_Q} F(x(t),y(t))\sqrt{(x'(t))^2+(y'(t))^2}dt"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.deCamposVectoriales,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.seaElCampo,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText: r"F(x,y) = F_1(x,y)\hat{i}+F_2(x,y)\hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\int_C \vec{F}\cdot d\vec{r}=\int_{t_P}^{t_Q} F_1(x,y)dx + \int_{t_P}^{t_Q} F_2(x,y)dy"),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetIntegralesDeLinea,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetIntegralesDeLinea,
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
