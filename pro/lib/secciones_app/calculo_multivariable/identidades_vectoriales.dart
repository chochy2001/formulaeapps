import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class IdentidadesVectoriales extends StatefulWidget {
  const IdentidadesVectoriales({super.key});

  @override
  IdentidadesVectorialesState createState() => IdentidadesVectorialesState();
}

class IdentidadesVectorialesState extends State<IdentidadesVectoriales> {
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
                AppLocalizations.of(context)!.identidadesVectoriales,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.identidadesVectoriales,
                    widgetName: kWidgetIdentidadesVectoriales,
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
                            )!.identidadesVectoriales,
                            widgetName: kWidgetIdentidadesVectoriales,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.identidadesVectoriales,
                            widgetName: kWidgetIdentidadesVectoriales,
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
                  Latex(formulaText: r"\nabla (f+g) = \nabla f+\nabla g"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\nabla (cf) = c\nabla f"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\nabla (fg) = g\nabla f +f\nabla g"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\nabla \cdot (\vec{F}+\vec{G}) = \nabla \cdot \vec{F}+\nabla \cdot \vec{G}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\nabla \times (\vec{F}+\vec{G}) = \nabla \times\vec{F}+\nabla \times\vec{G}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\nabla \cdot (\vec{F}+\vec{G}) = \vec{G}\cdot (\nabla \times \vec{F})-\vec{F}\cdot(\nabla \times \vec{G})",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\nabla \cdot (f\vec{F}) = f(\nabla\cdot\vec{F})+\vec{F}\cdot(\nabla f)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\nabla\cdot(\nabla \times \vec{F}) = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\nabla \times (f\vec{F}) = f\nabla \times \vec{F}+\nabla f \times \vec{F}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\nabla \times (\nabla \times \vec{F}) = \nabla (\nabla\cdot \vec{F})-\nabla ^2 \vec{F}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\nabla \times (\nabla f) = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\nabla ^2 (fg) = f\nabla ^2 g+g\nabla ^2 f +2\nabla f \cdot \nabla g",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetIdentidadesVectoriales),
                //Descargar PDF
                DescargarPDF(url: kWidgetIdentidadesVectoriales),
              ],
            ),

            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
