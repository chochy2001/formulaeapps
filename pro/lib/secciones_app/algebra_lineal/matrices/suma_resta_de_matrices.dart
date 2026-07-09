import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class SumaRestaDeMatrices extends StatefulWidget {
  const SumaRestaDeMatrices({super.key});

  @override
  SumaRestaDeMatricesState createState() => SumaRestaDeMatricesState();
}

class SumaRestaDeMatricesState extends State<SumaRestaDeMatrices> {
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
                      AppLocalizations.of(context)!.sumaYRestaDeMatrices,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .sumaYRestaDeMatrices,
                            widgetName: kWidgetSumaRestaDeMatrices),
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
                                        .sumaYRestaDeMatrices,
                                    widgetName: kWidgetSumaRestaDeMatrices),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .sumaYRestaDeMatrices,
                                    widgetName: kWidgetSumaRestaDeMatrices),
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sean,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A = \begin{pmatrix}a & b & c\\d & e & f\\g & h & i\\\end{pmatrix}"),
                        const SizedBox(height: 20),
                        const Latex(
                            formulaText:
                                r"B = \begin{pmatrix}j & k & l\\m & n & o\\p & q & r\\\end{pmatrix}"),
                        const SizedBox(height: 40),
                        const Latex(
                            formulaText:
                                r"A\pm B =\begin{pmatrix}a\pm j & b\pm k & c\pm l\\d\pm m & e\pm n & f\pm o\\g\pm p & h\pm q & i\pm r\\\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSumaRestaDeMatrices,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSumaRestaDeMatrices,
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
                              .condicionProductoMatrices,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"m\times n \thinspace n\times v"),
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
