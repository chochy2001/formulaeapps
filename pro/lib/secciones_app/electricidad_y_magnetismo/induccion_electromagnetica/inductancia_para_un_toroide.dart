import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class InductanciaParaUnToroide extends StatefulWidget {
  const InductanciaParaUnToroide({super.key});

  @override
  State<InductanciaParaUnToroide> createState() =>
      _InductanciaParaUnToroideState();
}

class _InductanciaParaUnToroideState extends State<InductanciaParaUnToroide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.inductanciaParaUnToroide,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.inductanciaParaUnToroide,
                    widgetName: kWidgetInductanciaParaUnToroide,
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
                            )!.inductanciaParaUnToroide,
                            widgetName: kWidgetInductanciaParaUnToroide,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.inductanciaParaUnToroide,
                            widgetName: kWidgetInductanciaParaUnToroide,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenFlujoMagneticoEnUnToroide,
                ),
                TextoEcuaciones(AppLocalizations.of(context)!.flujoMagnetico),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\Phi = \iint \vec{B}\cdot d\vec{A} = \frac{\mu_0NIe}{2\pi} \ln \left(\frac{r_e}{r_i}\right)",
                ),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.flujoTotalConcatenado,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\lambda = N\Phi_B = \frac{\mu_0N^2Ie}{2\pi}\ln \left(\frac{r_e}{r_i}\right)",
                ),
                const SizedBox(height: 30.0),
                TextoEcuaciones(AppLocalizations.of(context)!.laInductancia),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"L = \frac{\lambda}{I} = \frac{\mu_0N^2e}{2\pi}\ln \left(\frac{r_e}{r_i}\right)",
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetInductanciaParaUnToroide),
                //Descargar PDF
                DescargarPDF(url: kWidgetInductanciaParaUnToroide),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
