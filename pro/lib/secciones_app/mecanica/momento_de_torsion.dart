import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MomentoDeTorsion extends StatefulWidget {
  const MomentoDeTorsion({super.key});

  @override
  MomentoDeTorsionState createState() => MomentoDeTorsionState();
}

class MomentoDeTorsionState extends State<MomentoDeTorsion> {
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
                    AppLocalizations.of(context)!.momentoDeTorsion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.momentoDeTorsion,
                        widgetName: kWidgetMomentoDeTorsion,
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
                                )!.momentoDeTorsion,
                                widgetName: kWidgetMomentoDeTorsion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.momentoDeTorsion,
                                widgetName: kWidgetMomentoDeTorsion,
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
                  Latex(formulaText: r"M = F\,d"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F \perp d"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"M > 0 \;(\circlearrowleft) \quad , \quad M < 0 \;(\circlearrowright)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetMomentoDeTorsion),
            const DescargarPDF(url: kWidgetMomentoDeTorsion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
