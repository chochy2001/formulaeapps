import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class EfectoJoule extends StatefulWidget {
  const EfectoJoule({super.key});
  @override
  State<EfectoJoule> createState() => _EfectoJouleState();
}

class _EfectoJouleState extends State<EfectoJoule> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(onBannerReady: () { if (mounted) setState(() {}); });
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
              AppLocalizations.of(context)!.efectoJoule,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.efectoJoule,
                    widgetName: kWidgetEfectoJoule,
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
                              title: AppLocalizations.of(context)!.efectoJoule,
                              widgetName: kWidgetEfectoJoule),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.efectoJoule,
                              widgetName: kWidgetEfectoJoule),
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
                TextoEcuaciones(
                  AppLocalizations.of(context)!.desplazamientoDeElectrones,
                ),
                const SizedBox(height: 40.0),
                const Latex(formulaText: r"V= \frac{U}{q}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"P = \frac{U}{t} = Vi"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"P = Ri ^2 = \frac{V^2}{R}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"[P]_u = [W]: Watt"),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(urlImagen: kUrlImagenEfectoJoule),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeJoule,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.resistor,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(urlImagen: kUrlImagenEfectoJoule2),
                const ZoomImagePersonalizado(urlImagen: kUrlImagenEfectoJoule1),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.resistorPuro,
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetEfectoJoule,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetEfectoJoule,
            ),
          ],
        ),
      ),
    );
  }
}
