import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AxiomasDeCampoNumerosReales extends StatefulWidget {
  const AxiomasDeCampoNumerosReales({super.key});

  @override
  AxiomasDeCampoNumerosRealesState createState() =>
      AxiomasDeCampoNumerosRealesState();
}

class AxiomasDeCampoNumerosRealesState
    extends State<AxiomasDeCampoNumerosReales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChatGPTButton(
                  child: TituloPersonalizado(
                    AppLocalizations.of(context)!.axiomasDeCampoNumerosReales,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.axiomasDeCampoNumerosReales,
                        widgetName: kWidgetAxiomasDeCampoNumerosReales,
                      ),
                    );
                    return IconButton(
                      icon: isFavorite
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoritesNotifier.removeFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.axiomasDeCampoNumerosReales,
                                widgetName: kWidgetAxiomasDeCampoNumerosReales,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.axiomasDeCampoNumerosReales,
                                widgetName: kWidgetAxiomasDeCampoNumerosReales,
                              ),
                            );
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const ZoomPersonalizado(
              child: Column(
                children: [
                  Latex(
                    formulaText:
                        r"\forall a, b \in \mathbb{R},\ a + b \in \mathbb{R}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\forall a, b \in \mathbb{R},\ a + b = b + a",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\forall a, b, c \in \mathbb{R},\ (a + b) + c = a + (b + c)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\forall a \in \mathbb{R},\ a + 0 = a = 0 + a",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\forall a \in \mathbb{R},\ a + (-a) = 0 = -a + a",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\forall a, b \in \mathbb{R},\ a\,b \in \mathbb{R}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\forall a, b \in \mathbb{R},\ a\,b = b\,a",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\forall a, b, c \in \mathbb{R},\ (a\,b)\,c = a\,(b\,c)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\forall a \in \mathbb{R},\ a \cdot 1 = a = 1 \cdot a",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a \cdot a^{-1} = 1 = a^{-1} \cdot a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\forall a, b, c \in \mathbb{R},\quad a(b + c) = ab + ac \quad \text{y} \quad (b + c)a = ba + ca",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAxiomasDeCampoNumerosReales),
            const DescargarPDF(url: kWidgetAxiomasDeCampoNumerosReales),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
