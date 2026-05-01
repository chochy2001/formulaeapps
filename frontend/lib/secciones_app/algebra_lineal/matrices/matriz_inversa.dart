import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MatrizInversa extends StatefulWidget {
  const MatrizInversa({Key? key}) : super(key: key);

  @override
  MatrizInversaState createState() => MatrizInversaState();
}

class MatrizInversaState extends State<MatrizInversa> {
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
                      AppLocalizations.of(context)!.matrizInversa,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.matrizInversa,
                            widgetName: kWidgetMatrizInversa),
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
                                        .matrizInversa,
                                    widgetName: kWidgetMatrizInversa),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .matrizInversa,
                                    widgetName: kWidgetMatrizInversa),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Latex(
                            formulaText:
                                r"{A = \begin{pmatrix}1 & 0 & 3\\0 & 1 & -2\\1 & 1 & 2\end{pmatrix} }"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"{A^{-1} = \begin{pmatrix}4 & 3 & -3\\-2 & -1 & 2\\-1 & -1 & 1\end{pmatrix} }"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.maneraDeObtenerla,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A^{-1}= \frac{1}{\det A}\cdot adj \space A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .propiedadesDeLaMatrizInversa,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"x = A^{-1}\cdot b"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"(A\cdot B)^{-1}=B^{-1}\cdot A^{-1}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(A^{-1})^{-1}=A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A^{-1}A=I"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMatrizInversa,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMatrizInversa,
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
                          AppLocalizations.of(context)!
                              .laDiagonalPrincipalEstaCompuestaPorUnos,
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
