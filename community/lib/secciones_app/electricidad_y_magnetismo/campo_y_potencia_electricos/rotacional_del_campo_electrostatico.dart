import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class RotacionalDelCampoElectrostatico extends StatefulWidget {
  const RotacionalDelCampoElectrostatico({super.key});
  @override
  State<RotacionalDelCampoElectrostatico> createState() =>
      _RotacionalDelCampoElectrostaticoState();
}

class _RotacionalDelCampoElectrostaticoState
    extends State<RotacionalDelCampoElectrostatico> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(
      onBannerReady: () {
        if (mounted) setState(() {});
      },
    );
  }

  Widget get adContainer => _ads.banner;

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            TituloPersonalizado(
              AppLocalizations.of(context)!.rotacionalCampoElectrostatico,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.rotacionalCampoElectrostatico,
                    widgetName: kWidgetRotacionalDelCampoElectrostatico,
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
                            )!.rotacionalCampoElectrostatico,
                            widgetName: kWidgetRotacionalDelCampoElectrostatico,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.rotacionalCampoElectrostatico,
                            widgetName: kWidgetRotacionalDelCampoElectrostatico,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(
                      context,
                    )!.rotacionalCampoElectrostaticoCero,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"c_e = \oint \vec{E} \cdot d\vec{l}= \iint \left(\vec{\nabla}\times \vec{E}\right) \cdot d\vec{S} = 0",
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText: r"\vec{\nabla}\times \vec{E} = \vec{0}",
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.segundaLeyMaxwell,
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetRotacionalDelCampoElectrostatico),
            //Descargar PDF
            const DescargarPDF(url: kWidgetRotacionalDelCampoElectrostatico),
          ],
        ),
      ),
    );
  }
}
