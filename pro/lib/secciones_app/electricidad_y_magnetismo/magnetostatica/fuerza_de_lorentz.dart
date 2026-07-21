import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class FuerzaDeLorentz extends StatefulWidget {
  const FuerzaDeLorentz({super.key});

  @override
  State<FuerzaDeLorentz> createState() => _FuerzaDeLorentzState();
}

class _FuerzaDeLorentzState extends State<FuerzaDeLorentz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.fuerzaDeLorentz,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.fuerzaDeLorentz,
                    widgetName: kWidgetFuerzaDeLorentz,
                  ),
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
                            title: AppLocalizations.of(
                              context,
                            )!.fuerzaDeLorentz,
                            widgetName: kWidgetFuerzaDeLorentz,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.fuerzaDeLorentz,
                            widgetName: kWidgetFuerzaDeLorentz,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                ZoomImagePersonalizado(
                  urlImagen:
                      getImageUrlById(context, kImagenReglaDeLaManoDerecha) ??
                      kUrlImagenReglaDeLaManoDerecha,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\vec{F}_{em} = \vec{F}_{e} + \vec{F}_{m} = q\vec{E}+q\vec{v}\times \vec{B}",
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"\vec{F}_{m} = q\vec{v}\times \vec{B}",
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\vec{F}_{m} = q\frac{\vec{L}}{t}\times \vec{B} = \frac{q}{t}\vec{L}\times \vec{B}",
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"\vec{F}_{m} = i\vec{L}\times \vec{B}",
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\vec{F}_{m} = iLB\sin{\theta}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\vec{F}_{m} = NiLB\sin{\theta}"),
                const SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                  urlImagen:
                      getImageUrlById(context, kImagenFuerzaDeLorentz) ??
                      kUrlImagenFuerzaDeLorentz,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetFuerzaDeLorentz),
                //Descargar PDF
                DescargarPDF(url: kWidgetFuerzaDeLorentz),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
