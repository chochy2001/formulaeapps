import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class DerivadasDireccionales extends StatefulWidget {
  const DerivadasDireccionales({super.key});

  @override
  DerivadasDireccionalesState createState() => DerivadasDireccionalesState();
}

class DerivadasDireccionalesState extends State<DerivadasDireccionales> {
  bool seleccionadoMostrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.derivadasDireccionales,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.derivadasDireccionales,
                      widgetName: kWidgetDerivadasDireccionales),
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
                                  .derivadasDireccionales,
                              widgetName: kWidgetDerivadasDireccionales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .derivadasDireccionales,
                              widgetName: kWidgetDerivadasDireccionales),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 20.0,
            ),
            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.sean,
                  ),
                  const Latex(formulaText: r"f(x,y)"),
                  const SizedBox(height: 4),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.unafunciondedosvariables,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\vec{u} = u_1\hat{i}+u_2\hat{j}"),
                  const SizedBox(height: 4),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.unvectorunitario,
                  ),
                  const SizedBox(height: 30),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.derivadaDeFEnPEnDireccionDeU,
                  ),
                  const SizedBox(height: 30),
                  const Latex(
                      formulaText:
                          r"D_u F(x,y) =\lim_{S \to 0}\frac{f(x+Su_1,y+Su_2)-f(x,y)}{S}"),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetDerivadasDireccionales,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetDerivadasDireccionales,
                ),
              ],
            ),

            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
