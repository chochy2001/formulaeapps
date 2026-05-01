import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class DeterminantesAlgebraLineal extends StatefulWidget {
  const DeterminantesAlgebraLineal({Key? key}) : super(key: key);

  @override
  DeterminantesAlgebraLinealState createState() =>
      DeterminantesAlgebraLinealState();
}

class DeterminantesAlgebraLinealState
    extends State<DeterminantesAlgebraLineal> {
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
                      AppLocalizations.of(context)!.determinantes,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.determinantes,
                            widgetName: kWidgetDeterminantesAlgebraLineal),
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
                                        .determinantes,
                                    widgetName:
                                        kWidgetDeterminantesAlgebraLineal),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .determinantes,
                                    widgetName:
                                        kWidgetDeterminantesAlgebraLineal),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A=\begin{pmatrix}a & b \\c & d \\\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\det A = ad-bc"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.porCofactores,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.si,
                        ),
                        const Latex(
                            formulaText:
                                r"\mathsf{Sea}\space B=\begin{pmatrix}a & b & c\\d & e & f\\g & h & i\\\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\det B=(-1)^{1+1}a\begin{pmatrix}e & f\\h & i\\\end{pmatrix}+ (-1)^{1+2}b \begin{pmatrix}d & f\\g & i\\\end{pmatrix}+ (-1)^{1+3}c\begin{pmatrix}d & e\\g & h\\\end{pmatrix}= a(ei-fh)-b(di-fg)+c(dh-eg)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.definicionCofactor,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"C_{ij}=(-1)^{i+j}\cdot \det(M_{ij})"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"M_{ij}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.submatriz,
                        ),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetDeterminantesAlgebraLineal,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetDeterminantesAlgebraLineal,
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
                          height: 10.0,
                        ),
                        const Latex(formulaText: r"i,j"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.posicion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\det (M_{ij})"),
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
