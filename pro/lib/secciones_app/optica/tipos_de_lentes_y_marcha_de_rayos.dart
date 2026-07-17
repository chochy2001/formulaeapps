import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class TiposDeLentesYMarchaDeRayos extends StatefulWidget {
  const TiposDeLentesYMarchaDeRayos({super.key});

  @override
  TiposDeLentesYMarchaDeRayosState createState() => TiposDeLentesYMarchaDeRayosState();
}

class TiposDeLentesYMarchaDeRayosState extends State<TiposDeLentesYMarchaDeRayos> {
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
                    AppLocalizations.of(context)!.tiposDeLentesYMarchaDeRayos,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.tiposDeLentesYMarchaDeRayos,
                        widgetName: kWidgetTiposDeLentesYMarchaDeRayos,
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
                                title: AppLocalizations.of(context)!.tiposDeLentesYMarchaDeRayos,
                                widgetName: kWidgetTiposDeLentesYMarchaDeRayos,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.tiposDeLentesYMarchaDeRayos,
                                widgetName: kWidgetTiposDeLentesYMarchaDeRayos,
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
                  Latex(formulaText: r"\text{Biconvexa} \quad \text{Menisco convergente} \quad \text{Planoconvexa}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\text{Bicóncava} \quad \text{Planocóncava} \quad \text{Menisco divergente}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\text{Rayos paralelos} \longrightarrow \text{foco } F"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\text{Rayos paralelos} \longrightarrow \text{foco virtual } F"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"CF = \text{distancia focal} = f"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetTiposDeLentesYMarchaDeRayos),
            const DescargarPDF(url: kWidgetTiposDeLentesYMarchaDeRayos),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
