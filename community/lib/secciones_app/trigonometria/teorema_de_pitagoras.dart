import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TeoremaDePitagoras extends StatefulWidget {
  const TeoremaDePitagoras({super.key});
  @override
  State<TeoremaDePitagoras> createState() => _TeoremaDePitagorasState();
}

class _TeoremaDePitagorasState extends State<TeoremaDePitagoras> {
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.teoremaDePitagoras,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.teoremaDePitagoras,
                          widgetName: kWidgetTeoremaDePitagoras,
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
                                  )!.teoremaDePitagoras,
                                  widgetName: kWidgetTeoremaDePitagoras,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.teoremaDePitagoras,
                                  widgetName: kWidgetTeoremaDePitagoras,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a^2+b^2 = c^2"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetTeoremaDePitagoras),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetTeoremaDePitagoras),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
