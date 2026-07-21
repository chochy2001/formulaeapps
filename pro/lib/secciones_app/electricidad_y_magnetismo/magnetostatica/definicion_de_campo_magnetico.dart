import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class DefinicionDeCampoMagnetico extends StatefulWidget {
  const DefinicionDeCampoMagnetico({super.key});

  @override
  State<DefinicionDeCampoMagnetico> createState() =>
      _DefinicionDeCampoMagneticoState();
}

class _DefinicionDeCampoMagneticoState
    extends State<DefinicionDeCampoMagnetico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.definicionDeCampoMagnetico,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.definicionDeCampoMagnetico,
                    widgetName: kWidgetDefinicionDeCampoMagnetico,
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
                            )!.definicionDeCampoMagnetico,
                            widgetName: kWidgetDefinicionDeCampoMagnetico,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.definicionDeCampoMagnetico,
                            widgetName: kWidgetDefinicionDeCampoMagnetico,
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
                TextoEcuaciones(AppLocalizations.of(context)!.campoMagnetico),
                const SizedBox(height: 40.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenExperimentoOersted,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elCampoMagneticoB,
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(AppLocalizations.of(context)!.fenomenologia),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.laIntensidadDelCampoMagnetico,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.siLaVelocidadSeInvierte,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elCampoMagneticoSeAnula,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elCampoMagneticoEsTangente,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.laMagnitudDelCampoMagneticoDisminuye,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenExperimentoOersted,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"B\propto \frac{qv\sin{\theta}}{r^2}",
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"B=K \frac{qv\sin{\theta}}{r^2}"),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"K= \frac{\mu _0}{4\pi} = 10^{-7}\left[\frac{T\cdot m}{A}\right]",
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.constanteDePermeabilidad,
                ),
                const SizedBox(height: 10.0),
                const Latex(
                  formulaText:
                      r"\mu_0 = 4\pi \times 10^{-7}\left[\frac{T\cdot m}{A}\right]",
                ),
                const SizedBox(height: 40.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenCampoMagnetico,
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(AppLocalizations.of(context)!.leyDeBiotSavart),
                const SizedBox(height: 10.0),
                const Latex(
                  formulaText:
                      r"\vec{B}=\frac{\mu_0}{4\pi}\frac{q\vec{v}\times\hat{r}}{r^2}",
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\vec{B}=\frac{\mu_0}{4\pi}\frac{q\vec{v}\times\bar{r}}{r^3}",
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.lineasDeCampoMagnetico,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elCampoMagneticoSeRepresenta,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.aEstasLineasSeLesDenomina,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.laTangenteALaLineaDeCampo,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.lasLineasDeCampoMagneticoSonContinuas,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.lasLineasDeCampoMagneticoSonContinuas,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.laMagnitudDelCampoMagneticoEnUnPunto,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetDefinicionDeCampoMagnetico),
                //Descargar PDF
                DescargarPDF(url: kWidgetDefinicionDeCampoMagnetico),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
