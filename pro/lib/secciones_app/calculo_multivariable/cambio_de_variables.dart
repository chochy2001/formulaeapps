import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CambioDeVariables extends StatefulWidget {
  const CambioDeVariables({super.key});

  @override
  CambioDeVariablesState createState() => CambioDeVariablesState();
}

class CambioDeVariablesState extends State<CambioDeVariables> {
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
                AppLocalizations.of(context)!.cambioVariable,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.cambioVariable,
                      widgetName: kWidgetCambioDeVariables),
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
                                  AppLocalizations.of(context)!.cambioVariable,
                              widgetName: kWidgetCambioDeVariables),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title:
                                  AppLocalizations.of(context)!.cambioVariable,
                              widgetName: kWidgetCambioDeVariables),
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
                  const Latex(formulaText: r"\iint_{D_{xy}}F(x,y)dxdy"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText: r"\iint_{D_{uv}}F(H(u,v),G(u,v))|J|dudv"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.jacobiano,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"J=\begin{vmatrix}\frac{\partial H}{\partial u} & \frac{\partial H}{\partial v} \\\frac{\partial G}{\partial u} & \frac{\partial G}{\partial v} \\\end{vmatrix}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .coordenadasRectangularesapolares,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"x= r\cos\theta"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"y = r\sin\theta"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .coordenadasCartesianaACilindricas,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"x= r\cos\theta"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"y = r\sin\theta"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"z=z"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"r=\sqrt{x^2+y^2}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\theta = \tan^{-1}\frac{y}{x}"),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetCambioDeVariables,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetCambioDeVariables,
                ),
              ],
            ),

            const SizedBox(
              height: 20.0,
            ),
            //Notas
            Container(
              decoration: BoxDecoration(
                color: kColorBotones,
                border: Border.all(
                  color: kColorFondo,
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Notas(),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.eljacobianodelasfunciones,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"x(r,\theta),\space y(r,\theta)\space \mathsf{es}\space r"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const CapdesisLatex(),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
