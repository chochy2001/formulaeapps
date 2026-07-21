import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MotorDeCorrienteDirecta extends StatefulWidget {
  const MotorDeCorrienteDirecta({super.key});
  @override
  State<MotorDeCorrienteDirecta> createState() =>
      _MotorDeCorrienteDirectaState();
}

class _MotorDeCorrienteDirectaState extends State<MotorDeCorrienteDirecta> {
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
              AppLocalizations.of(context)!.motorDeCorrienteDirecta,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.motorDeCorrienteDirecta,
                    widgetName: kWidgetMotorDeCorrienteDirecta,
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
                            )!.motorDeCorrienteDirecta,
                            widgetName: kWidgetMotorDeCorrienteDirecta,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.motorDeCorrienteDirecta,
                            widgetName: kWidgetMotorDeCorrienteDirecta,
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
                ZoomImagePersonalizado(
                  urlImagen:
                      getImageUrlById(
                        context,
                        kImagenMotorDeCorrienteDirecta,
                      ) ??
                      kUrlImagenMotorDeCorrienteDirecta,
                ),
                TextoEcuaciones(AppLocalizations.of(context)!.motorMaquina),
                ZoomImagePersonalizado(
                  urlImagen:
                      getImageUrlById(
                        context,
                        kImagenMotorDeCorrienteDirecta1,
                      ) ??
                      kUrlImagenMotorDeCorrienteDirecta1,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"W= - \vec{p}_m \cdot \vec{B}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetMotorDeCorrienteDirecta),
            //Descargar PDF
            const DescargarPDF(url: kWidgetMotorDeCorrienteDirecta),
          ],
        ),
      ),
    );
  }
}
