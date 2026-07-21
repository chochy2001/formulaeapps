import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class VectorUnitario extends StatefulWidget {
  const VectorUnitario({super.key});
  @override
  State<VectorUnitario> createState() => _VectorUnitarioState();
}

class _VectorUnitarioState extends State<VectorUnitario> {
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
                    AppLocalizations.of(context)!.vectorUnitario,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(context)!.vectorUnitario,
                          widgetName: kWidgetVectorUnitario,
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
                                  )!.vectorUnitario,
                                  widgetName: kWidgetVectorUnitario,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.vectorUnitario,
                                  widgetName: kWidgetVectorUnitario,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.vectoresUnitariosBasicos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"\mathrm{i}=\langle 1,0,0\rangle",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"\mathrm{j}=\langle 0,1,0\rangle",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"\mathrm{k}=\langle 0,0,1\rangle",
                        ),
                        const SizedBox(height: 40),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.vectorUnitarioDireccionV,
                        ),
                        const SizedBox(height: 5),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.vectorUnitario,
                        ),
                        const Latex(
                          formulaText: r"\frac{\mathrm{v}}{|\mathrm{v}|}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetVectorUnitario),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetVectorUnitario),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
