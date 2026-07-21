import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class PropiedadesLimites extends StatefulWidget {
  const PropiedadesLimites({super.key});

  @override
  PropiedadesLimitesState createState() => PropiedadesLimitesState();
}

class PropiedadesLimitesState extends State<PropiedadesLimites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                //Propiedades de los limites
                ChatGPTButton(
                  child: TituloPersonalizado(
                    AppLocalizations.of(context)!.propiedadesDeLosLimites,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.propiedadesDeLosLimites,
                        widgetName: kWidgetPropiedadesLimites,
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
                                )!.propiedadesDeLosLimites,
                                widgetName: kWidgetPropiedadesLimites,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.propiedadesDeLosLimites,
                                widgetName: kWidgetPropiedadesLimites,
                              ),
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
                      Latex(formulaText: r"\lim_{x \to c}k=k"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\lim_{x \to c}k\cdot f(x)=k\cdot\lim_{x \to c}f(x)",
                      ),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\lim_{x \to c}[f(x)\pm g(x)]=\lim_{x \to c}f(x)\pm\lim_{x \to c}g(x)",
                      ),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\lim_{x \to c}[f(x)\cdot g(x)] = \lim_{x \to c}f(x)\cdot\lim_{x \to c}g(x)",
                      ),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\lim_{x \to c}\frac{f(x)}{g(x)} =  \frac{\lim_{x \to c}f(x)}{\lim_{x \to c}g(x)}",
                      ),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\lim_{x\to c}[f(x)^{g(x)}]=\lim_{x\to c}f(x)^{\lim_{x\to c}g(x)}",
                      ),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\lim_{x\to c}\log \cdot f(x) =\log\cdot \lim_{x\to c}f(x)",
                      ),

                      SizedBox(height: 70),
                      //Limites laterales
                      TextoEcuaciones('Límites Laterales'),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\lim_{x \to c}f(x)=L \space\space\mathsf{Si\space y\space solo\space si}",
                      ),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to c^-}f(x)=L"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to c^+}f(x)=L"),

                      SizedBox(height: 70),

                      //Limites al infinito
                      TextoEcuaciones('Límites al infinito'),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText: r"\lim_{x \to +\infty}\frac{k}{x^n} = 0",
                      ),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText: r"\lim_{x \to -\infty}\frac{k}{x^n} = 0",
                      ),

                      SizedBox(height: 40.0),
                    ],
                  ),
                ),

                //Boton para acceder al formulario en PDF
                const VerPDF(url: kWidgetPropiedadesLimites),
                //Descargar PDF
                const DescargarPDF(url: kWidgetPropiedadesLimites),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
