import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class Diferenciales extends StatefulWidget {
  const Diferenciales({super.key});

  @override
  DiferencialesState createState() => DiferencialesState();
}

class DiferencialesState extends State<Diferenciales> {
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
                    AppLocalizations.of(context)!.diferenciales,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.diferenciales,
                        widgetName: kWidgetDiferenciales,
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
                                )!.diferenciales,
                                widgetName: kWidgetDiferenciales,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.diferenciales,
                                widgetName: kWidgetDiferenciales,
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
                  Latex(formulaText: r"f'(x),\quad \frac{dy}{dx},\quad y'"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{df}{dx} = \lim_{h \to 0} \frac{f(x+h)-f(x)}{h} = \lim_{\Delta x \to 0} \frac{f(x+\Delta x)-f(x)}{\Delta x}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"d\!\left(\frac{u}{v}\right) = \frac{v\,du - u\,dv}{v^{2}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"d\!\left(\frac{c}{u}\right) = -\frac{c}{u^{2}}\,du",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"d\!\left(\frac{u}{c}\right) = \frac{du}{c}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"d\sqrt{u} = \frac{du}{2\sqrt{u}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"d\!\left(\sqrt[n]{u^{m}}\right) = \frac{m\,du}{n\,\sqrt[n]{u^{\,n-m}}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"d(|v|) = \frac{v}{|v|}\,dv"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"d(\operatorname{sen} u) = \cos u \cdot du",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"d(\cos u) = -\operatorname{sen} u \cdot du",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"d(\tan u) = \sec^{2} u \cdot du"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"d(\operatorname{arc\,sen} u) = \frac{du}{\sqrt{1-u^{2}}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"d(\operatorname{arc\,tan} u) = \frac{du}{1+u^{2}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"d(e^{x}) = e^{x} \cdot dx"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"d(\ln v) = \frac{dv}{v}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDiferenciales),
            const DescargarPDF(url: kWidgetDiferenciales),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
