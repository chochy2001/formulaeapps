import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class IntegralesExtraIntegral extends StatefulWidget {
  const IntegralesExtraIntegral({super.key});

  @override
  IntegralesExtraIntegralState createState() => IntegralesExtraIntegralState();
}

class IntegralesExtraIntegralState extends State<IntegralesExtraIntegral> {
  bool seleccionadoMostrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: SafeArea(
          child: ListView(
            children: [
              ChatGPTButton(
                child: TituloPersonalizado(
                  AppLocalizations.of(context)!.integralesExtras,
                ),
              ),
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                      title: AppLocalizations.of(context)!.integralesExtras,
                      widgetName: kWidgetIntegralesExtrasIntegral,
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
                              )!.integralesExtras,
                              widgetName: kWidgetIntegralesExtrasIntegral,
                            ),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                              title: AppLocalizations.of(
                                context,
                              )!.integralesExtras,
                              widgetName: kWidgetIntegralesExtrasIntegral,
                            ),
                          );
                        }
                      });
                    },
                  );
                },
              ),

              const SizedBox(height: 40.0),
              const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \frac{1}{\sqrt{a^2-u^2}}du = \sin^{-1}\left(\frac{u}{a}\right)+C = -\cos^{-1}\left(\frac{u}{a}\right)+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \frac{1}{u\sqrt{a^2\pm u^2}}du = \frac{1}{a}ln|\frac{u}{a+\sqrt{a^2\pm u^2}}|+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \frac{1}{\sqrt{u^2\pm a^2}}du = ln|u+\sqrt{u^2\pm a^2}|+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \frac{1}{u\sqrt{u^2- a^2}}du = \frac{1}{a}\cos^{-1}(\frac{a}{u})+C = \frac{1}{a}\sec^{-1}(\frac{u}{a})+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \frac{1}{a^2+u^2}du = \frac{1}{a}\tan^{-1}(\frac{u}{a})+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \frac{1}{a^2-u^2}du = \frac{1}{2a}ln|\frac{u+a}{u-a}|+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \frac{1}{u^2-a^2}du = \frac{1}{2a}ln|\frac{u-a}{u+a}|+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \sqrt{a^2+u^2}du = \frac{u}{2}\sqrt{a^2+u^2}+\frac{a^2}{2}ln|u+\sqrt{a^2+u^2}|+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \sqrt{a^2-u^2}du = \frac{u}{2}\sqrt{a^2-u^2}+\frac{a^2}{2}\sin^{-1}(\frac{u}{a})+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \sqrt{u^2\pm a^2}du = \frac{u}{2}\sqrt{u^2\pm a^2}\pm\frac{a^2}{2}ln|u+\sqrt{u^2\pm a^2}|+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \sqrt{2au- u^2}du= \frac{u-a}{2}\sqrt{2au-u^2}+\frac{a^2}{2}\cos^{-1}(\frac{a-u}{a})+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),

              const SizedBox(height: kEspacioEntreBotones),

              const Padding(padding: EdgeInsets.only(top: 10.0)),
              const SizedBox(height: 20.0),
              //Boton para acceder al formulario en PDF
              const Column(
                children: [
                  VerPDF(url: kWidgetIntegralesExtrasIntegral),
                  //Descargar PDF
                  DescargarPDF(url: kWidgetIntegralesExtrasIntegral),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
