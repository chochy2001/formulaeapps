import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class PotenciasReduccionTrigonometricasIntegral extends StatefulWidget {
  const PotenciasReduccionTrigonometricasIntegral({super.key});

  @override
  PotenciasReduccionTrigonometricasIntegralState createState() =>
      PotenciasReduccionTrigonometricasIntegralState();
}

class PotenciasReduccionTrigonometricasIntegralState
    extends State<PotenciasReduccionTrigonometricasIntegral> {
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
                    AppLocalizations.of(
                      context,
                    )!.potenciasReduccionTrigonometricasIntegral,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.potenciasReduccionTrigonometricasIntegral,
                        widgetName:
                            kWidgetPotenciasReduccionTrigonometricasIntegral,
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
                                )!.potenciasReduccionTrigonometricasIntegral,
                                widgetName:
                                    kWidgetPotenciasReduccionTrigonometricasIntegral,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.potenciasReduccionTrigonometricasIntegral,
                                widgetName:
                                    kWidgetPotenciasReduccionTrigonometricasIntegral,
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
                        r"\int \sin^{2} x\, dx = \frac{x}{2} - \frac{1}{4}\sin 2x + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \sin^{3} x\, dx = -\frac{3}{4}\cos x + \frac{1}{12}\cos 3x + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \sin^{n} x\, dx = -\frac{1}{n}\cos x\,\sin^{n-1} x + \frac{n-1}{n}\int \sin^{n-2} x\, dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\int \sin ax\, dx = -\frac{1}{a}\cos ax + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \cos^{2} x\, dx = \frac{x}{2} + \frac{1}{4}\sin 2x + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \cos^{3} x\, dx = \frac{3}{4}\sin x + \frac{1}{12}\sin 3x + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \cos^{n} x\, dx = \frac{1}{n}\sin x\,\cos^{n-1} x + \frac{n-1}{n}\int \cos^{n-2} x\, dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\int \cos ax\, dx = \frac{1}{a}\sin ax + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \tan x\, dx = -\ln\left|\cos x\right| + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \tan ax\, dx = -\frac{1}{a}\ln\left|\cos ax\right| + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \tan^{2} x\, dx = \tan x - x + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \tan^{n} x\, dx = \frac{\tan^{n-1} x}{n-1} - \int \tan^{n-2} x\, dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \cot x\, dx = \ln\left|\sin x\right| + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \cot ax\, dx = \frac{1}{a}\ln\left|\sin ax\right| + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \cot^{2} x\, dx = -x - \cot x + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \cot^{n} x\, dx = -\frac{\cot^{n-1} x}{n-1} - \int \cot^{n-2} x\, dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{\sin x} = \ln\left|\csc x - \cot x\right| + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{\sin^{n} x} = -\frac{1}{n-1}\frac{\cos x}{\sin^{n-1} x} + \frac{n-2}{n-1}\int \frac{dx}{\sin^{n-2} x}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{\cos x} = \ln\left|\sec x + \tan x\right| + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{\cos^{n} x} = \frac{1}{n-1}\frac{\sin x}{\cos^{n-1} x} + \frac{n-2}{n-1}\int \frac{dx}{\cos^{n-2} x}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int x^{n}\sin(ax)\,dx = -\frac{x^{n}}{a}\cos(ax) + \frac{n}{a}\int x^{n-1}\cos(ax)\,dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int x^{n}\cos(ax)\,dx = \frac{x^{n}}{a}\sin(ax) - \frac{n}{a}\int x^{n-1}\sin(ax)\,dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetPotenciasReduccionTrigonometricasIntegral),
            const DescargarPDF(
              url: kWidgetPotenciasReduccionTrigonometricasIntegral,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
