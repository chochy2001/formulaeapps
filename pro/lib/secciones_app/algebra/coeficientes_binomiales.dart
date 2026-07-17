import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CoeficientesBinomiales extends StatefulWidget {
  const CoeficientesBinomiales({super.key});

  @override
  CoeficientesBinomialesState createState() => CoeficientesBinomialesState();
}

class CoeficientesBinomialesState extends State<CoeficientesBinomiales> {
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
                    AppLocalizations.of(context)!.coeficientesBinomiales,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.coeficientesBinomiales,
                        widgetName: kWidgetCoeficientesBinomiales,
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
                                title: AppLocalizations.of(context)!.coeficientesBinomiales,
                                widgetName: kWidgetCoeficientesBinomiales,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.coeficientesBinomiales,
                                widgetName: kWidgetCoeficientesBinomiales,
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
                  Latex(formulaText: r"(x+y)^{n} = x^{n} + \binom{n}{1} x^{n-1} y + \binom{n}{2} x^{n-2} y^{2} + \binom{n}{3} x^{n-3} y^{3} + \dots + \binom{n}{n} y^{n}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\binom{n}{k} = \frac{n\,(n-1)(n-2)\cdots(n-k+1)}{k!} = \frac{n!}{k!\,(n-k)!} = \binom{n}{n-k}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\binom{n}{k} + \binom{n}{k+1} = \binom{n+1}{k+1}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(a+b)^{0} = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(a+b)^{1} = a+b"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(a+b)^{4} = a^{4} + 4a^{3}b + 6a^{2}b^{2} + 4ab^{3} + b^{4}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(a+b)^{5} = a^{5} + 5a^{4}b + 10a^{3}b^{2} + 10a^{2}b^{3} + 5ab^{4} + b^{5}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(a+b)^{6} = a^{6} + 6a^{5}b + 15a^{4}b^{2} + 20a^{3}b^{3} + 15a^{2}b^{4} + 6ab^{5} + b^{6}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(a+b)^{n} = a^{n} + \frac{n}{1!}\,a^{n-1}b + \frac{n(n-1)}{2!}\,a^{n-2}b^{2} + \frac{n(n-1)(n-2)}{3!}\,a^{n-3}b^{3} + \dots + \frac{n(n-1)\cdots(n-r+1)}{r!}\,a^{n-r}b^{r} + \dots + b^{n}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"0! = 1, \quad 1! = 1, \quad 2! = 2\cdot 1, \quad 3! = 3\cdot 2\cdot 1, \quad 4! = 4\cdot 3\cdot 2\cdot 1, \quad n! = n(n-1)(n-2)\cdots(3)(2)(1)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(1 \pm x)^{\alpha} = 1 \pm \binom{\alpha}{1}x + \binom{\alpha}{2}x^{2} \pm \binom{\alpha}{3}x^{3} + \dots"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\binom{\alpha}{n} = \frac{\alpha(\alpha-1)(\alpha-2)(\alpha-3)\cdots(\alpha-n+1)}{1\cdot 2\cdot 3\cdots n}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCoeficientesBinomiales),
            const DescargarPDF(url: kWidgetCoeficientesBinomiales),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
