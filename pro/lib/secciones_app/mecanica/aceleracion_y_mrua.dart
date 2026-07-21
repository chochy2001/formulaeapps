import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AceleracionYMrua extends StatefulWidget {
  const AceleracionYMrua({super.key});

  @override
  AceleracionYMruaState createState() => AceleracionYMruaState();
}

class AceleracionYMruaState extends State<AceleracionYMrua> {
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
                    AppLocalizations.of(context)!.aceleracionYMrua,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.aceleracionYMrua,
                        widgetName: kWidgetAceleracionYMrua,
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
                                )!.aceleracionYMrua,
                                widgetName: kWidgetAceleracionYMrua,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.aceleracionYMrua,
                                widgetName: kWidgetAceleracionYMrua,
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
                  Latex(formulaText: r"a = \frac{V_f - V_0}{t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a = \frac{\Delta V}{t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V_f = V_0 + a t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"d = \left( \frac{V_f + V_0}{2} \right) t",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"d = V_0 t + \frac{a t^{2}}{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V_f^{2} = V_0^{2} + 2 a d"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAceleracionYMrua),
            const DescargarPDF(url: kWidgetAceleracionYMrua),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
