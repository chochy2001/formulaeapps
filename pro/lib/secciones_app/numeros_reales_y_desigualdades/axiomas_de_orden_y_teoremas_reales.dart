import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AxiomasDeOrdenYTeoremasReales extends StatefulWidget {
  const AxiomasDeOrdenYTeoremasReales({super.key});

  @override
  AxiomasDeOrdenYTeoremasRealesState createState() => AxiomasDeOrdenYTeoremasRealesState();
}

class AxiomasDeOrdenYTeoremasRealesState extends State<AxiomasDeOrdenYTeoremasReales> {
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
                    AppLocalizations.of(context)!.axiomasDeOrdenYTeoremasReales,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.axiomasDeOrdenYTeoremasReales,
                        widgetName: kWidgetAxiomasDeOrdenYTeoremasReales,
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
                                title: AppLocalizations.of(context)!.axiomasDeOrdenYTeoremasReales,
                                widgetName: kWidgetAxiomasDeOrdenYTeoremasReales,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.axiomasDeOrdenYTeoremasReales,
                                widgetName: kWidgetAxiomasDeOrdenYTeoremasReales,
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
                  Latex(formulaText: r"\forall a, b \in \mathbb{R}:\ a < b \quad \text{o} \quad a = b \quad \text{o} \quad b < a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a < b \ \text{y}\ 0 < c \implies a\,c < b\,c"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\forall a \in \mathbb{R},\ a \cdot 0 = 0 = 0 \cdot a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\forall a \in \mathbb{R},\ -a = (-1)\,a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\forall a, b \in \mathbb{R},\ a(-b) = -(ab) = (-a)\,b"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\forall a \in \mathbb{R},\ -(-a) = a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\forall a, b \in \mathbb{R},\ (-a)(-b) = a\,b"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAxiomasDeOrdenYTeoremasReales),
            const DescargarPDF(url: kWidgetAxiomasDeOrdenYTeoremasReales),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
