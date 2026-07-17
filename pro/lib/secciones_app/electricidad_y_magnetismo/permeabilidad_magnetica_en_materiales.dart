import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class PermeabilidadMagneticaEnMateriales extends StatefulWidget {
  const PermeabilidadMagneticaEnMateriales({super.key});

  @override
  PermeabilidadMagneticaEnMaterialesState createState() => PermeabilidadMagneticaEnMaterialesState();
}

class PermeabilidadMagneticaEnMaterialesState extends State<PermeabilidadMagneticaEnMateriales> {
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
                    AppLocalizations.of(context)!.permeabilidadMagneticaEnMateriales,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.permeabilidadMagneticaEnMateriales,
                        widgetName: kWidgetPermeabilidadMagneticaEnMateriales,
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
                                title: AppLocalizations.of(context)!.permeabilidadMagneticaEnMateriales,
                                widgetName: kWidgetPermeabilidadMagneticaEnMateriales,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.permeabilidadMagneticaEnMateriales,
                                widgetName: kWidgetPermeabilidadMagneticaEnMateriales,
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
                  Latex(formulaText: r"\mu_{r} = \frac{\mu}{\mu_{0}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"B = \mu_{0}\, \mu_{r}\, H"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetPermeabilidadMagneticaEnMateriales),
            const DescargarPDF(url: kWidgetPermeabilidadMagneticaEnMateriales),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
