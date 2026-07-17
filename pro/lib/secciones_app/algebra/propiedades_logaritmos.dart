import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class PropiedadesLogaritmos extends StatefulWidget {
  const PropiedadesLogaritmos({super.key});

  @override
  PropiedadesLogaritmosState createState() => PropiedadesLogaritmosState();
}

class PropiedadesLogaritmosState extends State<PropiedadesLogaritmos> {
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
                    AppLocalizations.of(context)!.propiedadesLogaritmos2,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.propiedadesLogaritmos2,
                        widgetName: kWidgetPropiedadesLogaritmos,
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
                                title: AppLocalizations.of(context)!.propiedadesLogaritmos2,
                                widgetName: kWidgetPropiedadesLogaritmos,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.propiedadesLogaritmos2,
                                widgetName: kWidgetPropiedadesLogaritmos,
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
                  Latex(formulaText: r"\log_{10}=\log,\qquad \log_{e}=\ln,\qquad \log_{2}=\operatorname{lb}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log_{a}x=b"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log(x\cdot y)=\log x+\log y"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log\frac{x}{y}=\log x-\log y"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log x^{n}=n\log x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log\sqrt[n]{x}=\frac{1}{n}\log x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log(e^{x}) = \frac{x}{\ln(10)}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a^{x}=b=e^{x\ln a}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"x=\frac{\log b}{\log a}\qquad a=\sqrt[x]{b}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log_{10}x=\log_{10}e\cdot\ln x=0.434294\cdot\ln x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\ln x=\frac{\log_{10}x}{\log_{10}e}=2.302585\cdot\log_{10}x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e=2.71828183\ldots"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetPropiedadesLogaritmos),
            const DescargarPDF(url: kWidgetPropiedadesLogaritmos),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
