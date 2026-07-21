import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class PropiedadesDeLasMatrices extends StatefulWidget {
  const PropiedadesDeLasMatrices({super.key});

  @override
  PropiedadesDeLasMatricesState createState() =>
      PropiedadesDeLasMatricesState();
}

class PropiedadesDeLasMatricesState extends State<PropiedadesDeLasMatrices> {
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
                      AppLocalizations.of(context)!.propiedadesDeLasMatrices,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.propiedadesDeLasMatrices,
                          widgetName: kWidgetPropiedadesDeLasMatrices,
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
                                  )!.propiedadesDeLasMatrices,
                                  widgetName: kWidgetPropiedadesDeLasMatrices,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.propiedadesDeLasMatrices,
                                  widgetName: kWidgetPropiedadesDeLasMatrices,
                                ),
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
                          AppLocalizations.of(context)!.definicionABC,
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"A=\begin{bmatrix}a_{11} & \dotsm & a_{1n}\\: & \ddots & :\\a_{m1} & \dotsm & a_{mn}\end{bmatrix}",
                        ),
                        const SizedBox(height: 70),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.propiedades,
                        ),
                        const SizedBox(height: 50),
                        const Latex(formulaText: r"A+B=B+A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(A+B)+C=A+(B+C)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"A\cdot (B+C)= A\cdot B+A\cdot C",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"c\cdot (A+B)=c\cdot A+c\cdot B = cA+cB",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"(a+b)\cdot A = a \cdot A +b \cdot A",
                        ),
                        const SizedBox(height: 70),
                        const Latex(formulaText: r"1\cdot A =A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"A\cdot (B\cdot C)= (A\cdot B)\cdot C",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"a\cdot(A\cdot B)=(a\cdot A)\cdot B",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"(a\cdot b)\cdot A = a \cdot(b\cdot A)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"I\cdot A = A \cdot I = A"),
                        const SizedBox(height: 70),
                        const Latex(formulaText: r"A\cdot 0 = 0\cdot A = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A+0=0+A=A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"0 \cdot A = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"A+(-1\cdot A)=(-1\cdot A)+A=0",
                        ),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetPropiedadesDeLasMatrices),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetPropiedadesDeLasMatrices),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
