import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class EquilibrioDeCuerposRigidos extends StatefulWidget {
  const EquilibrioDeCuerposRigidos({super.key});

  @override
  EquilibrioDeCuerposRigidosState createState() =>
      EquilibrioDeCuerposRigidosState();
}

class EquilibrioDeCuerposRigidosState
    extends State<EquilibrioDeCuerposRigidos> {
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
                    AppLocalizations.of(context)!.equilibrioDeCuerposRigidos,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.equilibrioDeCuerposRigidos,
                        widgetName: kWidgetEquilibrioDeCuerposRigidos,
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
                                )!.equilibrioDeCuerposRigidos,
                                widgetName: kWidgetEquilibrioDeCuerposRigidos,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.equilibrioDeCuerposRigidos,
                                widgetName: kWidgetEquilibrioDeCuerposRigidos,
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
                  Latex(formulaText: r"\sum F_x = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sum F_y = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sum M = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetEquilibrioDeCuerposRigidos),
            const DescargarPDF(url: kWidgetEquilibrioDeCuerposRigidos),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
