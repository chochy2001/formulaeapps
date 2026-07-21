import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class InductanciaMutua extends StatefulWidget {
  const InductanciaMutua({super.key});

  @override
  State<InductanciaMutua> createState() => _InductanciaMutuaState();
}

class _InductanciaMutuaState extends State<InductanciaMutua> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.inductanciaMutua,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.inductanciaMutua,
                    widgetName: kWidgetInductanciaMutua,
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
                            )!.inductanciaMutua,
                            widgetName: kWidgetInductanciaMutua,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.inductanciaMutua,
                            widgetName: kWidgetInductanciaMutua,
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
                TextoEcuaciones(AppLocalizations.of(context)!.inductorTexto),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.inductanciaMutuaTexto,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(AppLocalizations.of(context)!.ecuacionGeneral),
                const SizedBox(height: 10.0),
                const Latex(formulaText: r"\Phi_B = MI'"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\Phi_B = LI \pm MI'"),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenInductanciaMutua,
                ),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.inductanciasMutuas,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"\Phi_{12} = \lambda_{12} = M_{12}I_2",
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"\Phi_{21} = \lambda_{21} = M_{21}I_1",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enElCasoDeFlujoConcatenado,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"-N_1I_1\Phi_{12} = -I_1\lambda_12 = -M_{12}I_2I_1",
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"-N_2I_2\Phi_{21} = -I_2\lambda_21 = -M_{21}I_1I_2",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enProductoDeFlujoTotal,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"W=-\vec{p}_m\cdot\vec{B} = -I\vec{A}\cdot \vec{B} = -I\lambda",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.porConservacionDeEnergia,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\lambda_{12}I_1 = \lambda_{21}I_2"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"M_{12} = M_{21}"),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"M = \frac{\lambda_{12}}{I_2} = \frac{\lambda_{21}}{I_1}",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.inductanciaPropiaYMutua,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"M^2 \leq \frac{\lambda_1}{I_1}\cdot\frac{\lambda_2}{I_2}",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.disminucionDeFlujoConDistancia,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"M = k \sqrt{L_1L_2}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.constanteDeAcoplamiento,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"0 \leq k \leq 1"),
                const SizedBox(height: 20.0),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetInductanciaMutua),
                //Descargar PDF
                DescargarPDF(url: kWidgetInductanciaMutua),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
