import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MatrizTranspuesta extends StatefulWidget {
  const MatrizTranspuesta({super.key});

  @override
  MatrizTranspuestaState createState() => MatrizTranspuestaState();
}

class MatrizTranspuestaState extends State<MatrizTranspuesta> {
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
                      AppLocalizations.of(context)!.matrizTranspuesta,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title:
                                AppLocalizations.of(context)!.matrizTranspuesta,
                            widgetName: kWidgetMatrizTranspuesta),
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
                                        .matrizTranspuesta,
                                    widgetName: kWidgetMatrizTranspuesta),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .matrizTranspuesta,
                                    widgetName: kWidgetMatrizTranspuesta),
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
                        const Latex(
                            formulaText:
                                r"A = \begin{pmatrix}a_{11} & a_{12} & a_{13}\\a_{21} & a_{22} & a_{23}\\a_{31} & a_{32} & a_{33}\\\end{pmatrix}"),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A^T = \begin{pmatrix}a_{11} & a_{21} & a_{31}\\a_{12} & a_{22} & a_{32}\\a_{13} & a_{23} & a_{33}\\\end{pmatrix}"),

                        const SizedBox(height: kEspacioEntreBotones),

                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .propiedadesDeLaMatrizTranspuesta,
                        ),
                        const SizedBox(
                          height: kEspacioEntreBotones,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(A^T)^T = A"),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(A+B)^T=A^T+B^T"),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(c\cdot A)^T=c\cdot A^T"),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(A\cdot B) = B^T \cdot A^T"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Boton para acceder al formulario en PDF
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMatrizTranspuesta,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMatrizTranspuesta,
                  ),
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
                        const SizedBox(
                          height: kEspacioEntreBotones,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .seCambianLasFilasPorLasColumnas,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
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
