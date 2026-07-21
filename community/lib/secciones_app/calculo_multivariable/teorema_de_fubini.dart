import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TeoremaDeFubini extends StatefulWidget {
  const TeoremaDeFubini({super.key});
  @override
  State<TeoremaDeFubini> createState() => _TeoremaDeFubiniState();
}

class _TeoremaDeFubiniState extends State<TeoremaDeFubini> {
  bool seleccionadoMostrar = true;

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
            TituloPersonalizado(AppLocalizations.of(context)!.teoremaFubini),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.teoremaFubini,
                    widgetName: kWidgetTeoremaDeFubini,
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
                            title: AppLocalizations.of(context)!.teoremaFubini,
                            widgetName: kWidgetTeoremaDeFubini,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(context)!.teoremaFubini,
                            widgetName: kWidgetTeoremaDeFubini,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            const ZoomPersonalizado(
              child: Column(
                children: [
                  SizedBox(height: kEspacioEntreBotones),
                  SizedBox(height: kEspacioEntreBotones),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\iint_{|a,b|\times |c,d|}f(x,y)dxdy"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"= \int_a^b\left(\int_c^d f(x,y)dy\right)dx",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"= \int_c^d\left(\int_a^b f(x,y)dx\right)dy",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  SizedBox(height: kEspacioEntreBotones),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetTeoremaDeFubini),
            //Descargar PDF
            const DescargarPDF(url: kWidgetTeoremaDeFubini),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
