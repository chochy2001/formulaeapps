import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MatrizAdjunta extends StatefulWidget {
  const MatrizAdjunta({super.key});

  @override
  MatrizAdjuntaState createState() => MatrizAdjuntaState();
}

class MatrizAdjuntaState extends State<MatrizAdjunta> {
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
                      AppLocalizations.of(context)!.matrizAdjunta,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.matrizAdjunta,
                            widgetName: kWidgetMatrizAdjunta),
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
                                        .matrizAdjunta,
                                    widgetName: kWidgetMatrizAdjunta),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .matrizAdjunta,
                                    widgetName: kWidgetMatrizAdjunta),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: kEspacioEntreBotones,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .matrizTranspuestaDeCofactoresDeA,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"Adj \thinspace A = \begin{pmatrix}C_{11} & C_{12} & \cdots & C_{1j} \\C_{21} &  C_{22} & \cdots & C_{2j}\\\vdots & \vdots & \ddots & \vdots\\C_{i1} & C_{i2} & \cdots & C_{ij}\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"Adj \thinspace A = \begin{pmatrix}C_{11} & C_{21} & \cdots & C_{i1} \\C_{12} &  C_{22} & \cdots & C_{i2}\\\vdots & \vdots & \ddots & \vdots\\C_{1j} & C_{2j} & \cdots & C_{ij}\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.elCofactorSeDefineComo,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"{C_{ij} = (-1)^{i+j}\cdot \det (M_{ij})}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMatrizAdjunta,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMatrizAdjunta,
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.obtenerSubmatriz,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"i, j"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.posicion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\det( {M_{ij})}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.menorDeA,
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
