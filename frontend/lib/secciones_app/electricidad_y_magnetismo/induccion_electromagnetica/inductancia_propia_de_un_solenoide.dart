import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class InductanciaPropiaDeUnSolenoide extends StatefulWidget {
  const InductanciaPropiaDeUnSolenoide({Key? key}) : super(key: key);

  @override
  State<InductanciaPropiaDeUnSolenoide> createState() =>
      _InductanciaPropiaDeUnSolenoideState();
}

class _InductanciaPropiaDeUnSolenoideState
    extends State<InductanciaPropiaDeUnSolenoide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.inductanciaPropiaDeUnSolenoide,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .inductanciaPropiaDeUnSolenoide,
                      widgetName: kWidgetInductanciaPropiaDeUnSolenoide),
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
                                  .inductanciaPropiaDeUnSolenoide,
                              widgetName:
                                  kWidgetInductanciaPropiaDeUnSolenoide),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .inductanciaPropiaDeUnSolenoide,
                              widgetName:
                                  kWidgetInductanciaPropiaDeUnSolenoide),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const ZoomImagePersonalizado(
                urlImagen: kUrlImagenInductanciaPropiaDeUnSolenoide),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .flujoMagneticoEnUnSolenoideIdeal,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\Phi_B = \iint \vec{B} \cdot d\vec{A} = \mu_0 nIA"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.flujoTotalConcatenado,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\lambda = N\Phi_B = \frac{\mu_0 N^2IA}{l}"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laInductancia,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"L = \frac{\lambda }{I} = \frac{\mu_0 N^2A}{l}"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetInductanciaPropiaDeUnSolenoide,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetInductanciaPropiaDeUnSolenoide,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
