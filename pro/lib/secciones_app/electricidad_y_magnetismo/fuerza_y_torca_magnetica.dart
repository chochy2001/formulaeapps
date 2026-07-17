import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class FuerzaYTorcaMagnetica extends StatefulWidget {
  const FuerzaYTorcaMagnetica({super.key});

  @override
  FuerzaYTorcaMagneticaState createState() => FuerzaYTorcaMagneticaState();
}

class FuerzaYTorcaMagneticaState extends State<FuerzaYTorcaMagnetica> {
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
                    AppLocalizations.of(context)!.fuerzaYTorcaMagnetica,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.fuerzaYTorcaMagnetica,
                        widgetName: kWidgetFuerzaYTorcaMagnetica,
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
                                title: AppLocalizations.of(context)!.fuerzaYTorcaMagnetica,
                                widgetName: kWidgetFuerzaYTorcaMagnetica,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.fuerzaYTorcaMagnetica,
                                widgetName: kWidgetFuerzaYTorcaMagnetica,
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
                  Latex(formulaText: r"F = B I L"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F = B I L \sin\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tau = N B I A \cos\alpha"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tau = N B I A \sin\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetFuerzaYTorcaMagnetica),
            const DescargarPDF(url: kWidgetFuerzaYTorcaMagnetica),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
