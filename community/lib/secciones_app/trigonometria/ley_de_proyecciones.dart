import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class LeyDeProyecciones extends StatefulWidget {
  const LeyDeProyecciones({super.key});
  @override
  State<LeyDeProyecciones> createState() => _LeyDeProyeccionesState();
}

class _LeyDeProyeccionesState extends State<LeyDeProyecciones> {
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
                    AppLocalizations.of(context)!.leyDeProyecciones,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.leyDeProyecciones,
                          widgetName: kWidgetLeyDeProyecciones,
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
                                  )!.leyDeProyecciones,
                                  widgetName: kWidgetLeyDeProyecciones,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.leyDeProyecciones,
                                  widgetName: kWidgetLeyDeProyecciones,
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
                        Latex(formulaText: r"a \cos B + b\cos A = c"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a \cos C + c\cos A = b"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"b \cos C + c\cos B = a"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetLeyDeProyecciones),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetLeyDeProyecciones),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
