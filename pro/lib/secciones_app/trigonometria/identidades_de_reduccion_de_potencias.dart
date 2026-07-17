import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class IdentidadesDeReduccionDePotencias extends StatefulWidget {
  const IdentidadesDeReduccionDePotencias({super.key});

  @override
  IdentidadesDeReduccionDePotenciasState createState() => IdentidadesDeReduccionDePotenciasState();
}

class IdentidadesDeReduccionDePotenciasState extends State<IdentidadesDeReduccionDePotencias> {
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
                    AppLocalizations.of(context)!.identidadesDeReduccionDePotencias,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.identidadesDeReduccionDePotencias,
                        widgetName: kWidgetIdentidadesDeReduccionDePotencias,
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
                                title: AppLocalizations.of(context)!.identidadesDeReduccionDePotencias,
                                widgetName: kWidgetIdentidadesDeReduccionDePotencias,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.identidadesDeReduccionDePotencias,
                                widgetName: kWidgetIdentidadesDeReduccionDePotencias,
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
                  Latex(formulaText: r"\operatorname{sen}^{2}A = \dfrac{1}{2} - \dfrac{1}{2}\cos 2A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\cos^{2}A = \dfrac{1}{2} + \dfrac{1}{2}\cos 2A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\operatorname{sen}^{3}A = \dfrac{3}{4}\operatorname{sen} A - \dfrac{1}{4}\operatorname{sen} 3A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\cos^{3}A = \dfrac{3}{4}\cos A + \dfrac{1}{4}\cos 3A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\operatorname{sen}^{4}A = \dfrac{3}{8} - \dfrac{1}{2}\cos 2A + \dfrac{1}{8}\cos 4A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\cos^{4}A = \dfrac{3}{8} + \dfrac{1}{2}\cos 2A + \dfrac{1}{8}\cos 4A"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetIdentidadesDeReduccionDePotencias),
            const DescargarPDF(url: kWidgetIdentidadesDeReduccionDePotencias),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
