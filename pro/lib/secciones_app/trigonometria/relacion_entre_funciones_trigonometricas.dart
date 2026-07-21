import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class RelacionEntreFuncionesTrigonometricas extends StatefulWidget {
  const RelacionEntreFuncionesTrigonometricas({super.key});

  @override
  RelacionEntreFuncionesTrigonometricasState createState() =>
      RelacionEntreFuncionesTrigonometricasState();
}

class RelacionEntreFuncionesTrigonometricasState
    extends State<RelacionEntreFuncionesTrigonometricas> {
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
                    )!.relacionEntreFuncionesTrigonometricas,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.relacionEntreFuncionesTrigonometricas,
                        widgetName:
                            kWidgetRelacionEntreFuncionesTrigonometricas,
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
                                )!.relacionEntreFuncionesTrigonometricas,
                                widgetName:
                                    kWidgetRelacionEntreFuncionesTrigonometricas,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.relacionEntreFuncionesTrigonometricas,
                                widgetName:
                                    kWidgetRelacionEntreFuncionesTrigonometricas,
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
                        r"\operatorname{sen}a=\sqrt{1-\cos^{2}a}=\frac{\operatorname{tg}a}{\sqrt{1+\operatorname{tg}^{2}a}}=\frac{1}{\sqrt{1+\operatorname{cot}^{2}a}}=\frac{\sqrt{\sec^{2}a-1}}{\sec a}=\frac{1}{\csc a}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\cos a=\sqrt{1-\operatorname{sen}^{2}a}=\frac{1}{\sqrt{1+\operatorname{tg}^{2}a}}=\frac{\operatorname{cot}a}{\sqrt{1+\operatorname{cot}^{2}a}}=\frac{1}{\sec a}=\frac{\sqrt{\csc^{2}a-1}}{\csc a}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\operatorname{tg}a=\frac{\operatorname{sen}a}{\sqrt{1-\operatorname{sen}^{2}a}}=\frac{\sqrt{1-\cos^{2}a}}{\cos a}=\frac{1}{\operatorname{cot}a}=\sqrt{\sec^{2}a-1}=\frac{1}{\sqrt{\csc^{2}a-1}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\operatorname{cot}a=\frac{\sqrt{1-\operatorname{sen}^{2}a}}{\operatorname{sen}a}=\frac{\cos a}{\sqrt{1-\cos^{2}a}}=\frac{1}{\operatorname{tg}a}=\frac{1}{\sqrt{\sec^{2}a-1}}=\sqrt{\csc^{2}a-1}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\sec a=\frac{1}{\sqrt{1-\operatorname{sen}^{2}a}}=\frac{1}{\cos a}=\sqrt{1+\operatorname{tg}^{2}a}=\frac{\sqrt{1+\operatorname{cot}^{2}a}}{\operatorname{cot}a}=\frac{\csc a}{\sqrt{\csc^{2}a-1}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\csc a=\frac{1}{\operatorname{sen}a}=\frac{1}{\sqrt{1-\cos^{2}a}}=\frac{\sqrt{1+\operatorname{tg}^{2}a}}{\operatorname{tg}a}=\sqrt{1+\operatorname{cot}^{2}a}=\frac{\sec a}{\sqrt{\sec^{2}a-1}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetRelacionEntreFuncionesTrigonometricas),
            const DescargarPDF(
              url: kWidgetRelacionEntreFuncionesTrigonometricas,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
