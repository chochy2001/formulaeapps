import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DerivadasHiperbolicasInversas extends StatefulWidget {
  const DerivadasHiperbolicasInversas({super.key});

  @override
  DerivadasHiperbolicasInversasState createState() => DerivadasHiperbolicasInversasState();
}

class DerivadasHiperbolicasInversasState extends State<DerivadasHiperbolicasInversas> {
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
                    AppLocalizations.of(context)!.derivadasHiperbolicasInversas,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.derivadasHiperbolicasInversas,
                        widgetName: kWidgetDerivadasHiperbolicasInversas,
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
                                title: AppLocalizations.of(context)!.derivadasHiperbolicasInversas,
                                widgetName: kWidgetDerivadasHiperbolicasInversas,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.derivadasHiperbolicasInversas,
                                widgetName: kWidgetDerivadasHiperbolicasInversas,
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
                  Latex(formulaText: r"\frac{d}{dx}\operatorname{senh}^{-1}u=\frac{1}{\sqrt{u^{2}+1}}\cdot\frac{du}{dx}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{d}{dx}\cosh^{-1}u=\frac{1}{\sqrt{u^{2}-1}}\cdot\frac{du}{dx}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{d}{dx}\tanh^{-1}u=\frac{1}{1-u^{2}}\cdot\frac{du}{dx}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{d}{dx}\coth^{-1}u=\frac{1}{1-u^{2}}\cdot\frac{du}{dx}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{d}{dx}\operatorname{sech}^{-1}u=-\frac{1}{u\sqrt{1-u^{2}}}\cdot\frac{du}{dx}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{d}{dx}\operatorname{csch}^{-1}u=-\frac{1}{u\sqrt{u^{2}+1}}\cdot\frac{du}{dx}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDerivadasHiperbolicasInversas),
            const DescargarPDF(url: kWidgetDerivadasHiperbolicasInversas),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
