import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class SerieTaylorMaClaurin extends StatefulWidget {
  const SerieTaylorMaClaurin({Key? key}) : super(key: key);

  @override
  SerieTaylorMaClaurinState createState() => SerieTaylorMaClaurinState();
}

class SerieTaylorMaClaurinState extends State<SerieTaylorMaClaurin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChatGPTButton(
                    child: TituloPersonalizado(
                      AppLocalizations.of(context)!.serieTaylorMaclaurin,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .serieTaylorMaclaurin,
                            widgetName: kWidgetSerieDeTaylorYMaClaurin),
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
                                        .serieTaylorMaclaurin,
                                    widgetName: kWidgetSerieDeTaylorYMaClaurin),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .serieTaylorMaclaurin,
                                    widgetName: kWidgetSerieDeTaylorYMaClaurin),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: kEspacioEntreBotones,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieDeTaylor,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Column(
                          children: [
                            SizedBox(height: 10),
                            Latex(
                                formulaText:
                                    r"f(x)=\sum_{n=0}^{\infty} \frac{f^{(n)}(a)}{n!}(x-a)^n"),
                            SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieDeMaclaurin,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Column(
                          children: [
                            SizedBox(height: 10),
                            Latex(
                                formulaText:
                                    r"f(x)=\sum_{n=0}^{\infty} \frac{f^{(n)}(0)}{n!}x^n"),
                            SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieDePotencias,
                        ),
                        const Column(
                          children: [
                            SizedBox(height: kEspacioEntreBotones),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"e^x=1+x+\frac{x^2}{2!}+\frac{x^3}{3!}+\frac{x^4}{4!}+..."),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"\sin x=x-\frac{x^3}{3!}+\frac{x^5}{5!}-\frac{x^7}{7!}+..."),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"\cos x=1-\frac{x^2}{2!}+\frac{x^4}{4!}-\frac{x^6}{6!}+..."),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"\tan^{-1}x=x-\frac{x^3}{3}+\frac{x^5}{5}-\frac{x^7}{7}+..."),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"\ln(1+x)=x-\frac{x^2}{2}+\frac{x^3}{3}-\frac{x^4}{4}+..."),
                            SizedBox(height: kEspacioEntreBotones),
                            SizedBox(height: kEspacioEntreBotones),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSerieDeTaylorYMaClaurin,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSerieDeTaylorYMaClaurin,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
