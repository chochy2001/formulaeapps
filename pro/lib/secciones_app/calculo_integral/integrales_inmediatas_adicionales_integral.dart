import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class IntegralesInmediatasAdicionalesIntegral extends StatefulWidget {
  const IntegralesInmediatasAdicionalesIntegral({super.key});

  @override
  IntegralesInmediatasAdicionalesIntegralState createState() =>
      IntegralesInmediatasAdicionalesIntegralState();
}

class IntegralesInmediatasAdicionalesIntegralState
    extends State<IntegralesInmediatasAdicionalesIntegral> {
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
                    )!.integralesInmediatasAdicionalesIntegral,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.integralesInmediatasAdicionalesIntegral,
                        widgetName:
                            kWidgetIntegralesInmediatasAdicionalesIntegral,
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
                                )!.integralesInmediatasAdicionalesIntegral,
                                widgetName:
                                    kWidgetIntegralesInmediatasAdicionalesIntegral,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.integralesInmediatasAdicionalesIntegral,
                                widgetName:
                                    kWidgetIntegralesInmediatasAdicionalesIntegral,
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
                        r"\frac{dF}{dx}=f(x)\ \Longrightarrow\ \int f(x)\,dx=F(x)+C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{u'(x)}{u(x)}\,dx=\ln\left|u(x)\right|+C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int u(x)\,u'(x)\,dx=\frac{1}{2}\left[u(x)\right]^{2}+C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{(x-a)(x-b)}=\frac{1}{a-b}\ln\left|\frac{x-a}{x-b}\right|+C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{(x-a)^{n}}=-\frac{1}{(n-1)(x-a)^{n-1}}+C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{x\,dx}{x^{2}+a^{2}}=\frac{1}{2}\ln\left(x^{2}+a^{2}\right)+C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{(x^{2}+a^{2})^{n}}=\frac{x}{2a^{2}(n-1)(x^{2}+a^{2})^{n-1}}+\frac{2n-3}{2a^{2}(n-1)}\int \frac{dx}{(x^{2}+a^{2})^{n-1}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{\sqrt{ax+b}}=\frac{2}{a}\sqrt{ax+b}+C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetIntegralesInmediatasAdicionalesIntegral),
            const DescargarPDF(
              url: kWidgetIntegralesInmediatasAdicionalesIntegral,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
