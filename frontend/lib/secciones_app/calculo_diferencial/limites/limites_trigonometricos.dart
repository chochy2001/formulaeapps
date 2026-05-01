import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LimitesTrigonometricos extends StatefulWidget {
  const LimitesTrigonometricos({Key? key}) : super(key: key);

  @override
  LimitesTrigonometricosState createState() => LimitesTrigonometricosState();
}

class LimitesTrigonometricosState extends State<LimitesTrigonometricos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                ChatGPTButton(
                  child: TituloPersonalizado(
                    AppLocalizations.of(context)!.limitesTrigonometricos,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                          title: AppLocalizations.of(context)!
                              .limitesTrigonometricos,
                          widgetName: kWidgetLimitesTrigonometricos),
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
                                      .limitesTrigonometricos,
                                  widgetName: kWidgetLimitesTrigonometricos),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                  title: AppLocalizations.of(context)!
                                      .limitesTrigonometricos,
                                  widgetName: kWidgetLimitesTrigonometricos),
                            );
                          }
                        });
                      },
                    );
                  },
                ),

                const SizedBox(height: kEspacioEntreBotones),
                const ZoomPersonalizado(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Latex(formulaText: r"\lim_{x \to 0}\frac{\sin{x}}{x}=1"),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to 0}\frac{x}{\sin{x}}=1"),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to 0}\sin{x}=0"),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText: r"\lim_{x \to 0}\frac{\sin{kx}}{kx}=1"),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to 0}\cos{x}=1"),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText: r"\lim_{x \to 0}\frac{1-\cos{x}}{x}=0"),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to 0}\frac{1-\cos{x}}{x^2}=\frac{1}{2}"),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to 0}\frac{\tan{x}}{x}=1"),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to 0}\frac{x}{\tan{x}}=1"),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText: r"\lim_{x \to 0}\frac{\tan{kx}}{kx}=1"),
                      SizedBox(height: kEspacioEntreBotones),
                    ],
                  ),
                ),

                //Boton para acceder al formulario en PDF
                const VerPDF(
                  url: kWidgetLimitesTrigonometricos,
                ),
                //Descargar PDF
                const DescargarPDF(
                  url: kWidgetLimitesTrigonometricos,
                ),

                const SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
