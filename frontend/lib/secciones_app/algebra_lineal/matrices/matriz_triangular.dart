import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MatrizTriangular extends StatefulWidget {
  const MatrizTriangular({Key? key}) : super(key: key);

  @override
  MatrizTriangularState createState() => MatrizTriangularState();
}

class MatrizTriangularState extends State<MatrizTriangular> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChatGPTButton(
                    child: TituloPersonalizado(
                      AppLocalizations.of(context)!.matrizTriangular,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title:
                                AppLocalizations.of(context)!.matrizTriangular,
                            widgetName: kWidgetMatrizTriangular),
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
                                        .matrizTriangular,
                                    widgetName: kWidgetMatrizTriangular),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .matrizTriangular,
                                    widgetName: kWidgetMatrizTriangular),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .matrizTriangularSuperior,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A = \begin{pmatrix}a_{11} & a_{12} & a_{13}\\0 & a_{22} & a_{23}\\0 & 0 & a_{33}\\\end{pmatrix}"),

                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .matrizTriangularInferior,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A^T = \begin{pmatrix}a_{11} & 0 & 0\\a_{12} & a_{22} & 0\\a_{13} & a_{23} & a_{33}\\\end{pmatrix}"),

                        const SizedBox(height: kEspacioEntreBotones),

                        const TextoEcuaciones(
                            'Propiedades de la Matriz Triangular'),
                        const SizedBox(
                          height: kEspacioEntreBotones,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .caracteristicasMatrizTriangular,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"5) \det A= a_{11}\cdot a_{22}\cdot a_{33}"),

                        const SizedBox(
                          height: kEspacioEntreBotones,
                        ),
                        //Boton para acceder al formulario en PDF
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMatrizTriangular,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMatrizTriangular,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
