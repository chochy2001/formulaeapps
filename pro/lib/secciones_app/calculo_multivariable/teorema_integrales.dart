import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class TeoremaIntegrales extends StatefulWidget {
  const TeoremaIntegrales({super.key});

  @override
  TeoremaIntegralesState createState() => TeoremaIntegralesState();
}

class TeoremaIntegralesState extends State<TeoremaIntegrales> {
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
                AppLocalizations.of(context)!.teoremaIntegrales,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.teoremaIntegrales,
                    widgetName: kWidgetTeoremaIntegrales,
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
                            title: AppLocalizations.of(
                              context,
                            )!.teoremaIntegrales,
                            widgetName: kWidgetTeoremaIntegrales,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.teoremaIntegrales,
                            widgetName: kWidgetTeoremaIntegrales,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.teoremaDeStokes,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"\int_C \vec{F}\cdot d\vec{r} = \iint_S \nabla \times F\cdot dS",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.teoremaDeGreen),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"\int_D\int\left(\frac{\partial Q}{\partial x}- \frac{\partial P}{\partial y}\right)dA = \int_C\vec{F}\cdot d\vec{r}= \int_C Pdx+Qdy",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetTeoremaIntegrales),
                //Descargar PDF
                DescargarPDF(url: kWidgetTeoremaIntegrales),
              ],
            ),

            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
