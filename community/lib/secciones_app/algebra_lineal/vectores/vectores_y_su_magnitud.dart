import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class VectoresYSuMagnitud extends StatefulWidget {
  const VectoresYSuMagnitud({super.key});
  @override
  State<VectoresYSuMagnitud> createState() => _VectoresYSuMagnitudState();
}

class _VectoresYSuMagnitudState extends State<VectoresYSuMagnitud> {
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.vectoresYSuMagnitud,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .vectoresYSuMagnitud,
                            widgetName: kWidgetVectoresYSuMagnitud),
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
                                        .vectoresYSuMagnitud,
                                    widgetName: kWidgetVectoresYSuMagnitud),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .vectoresYSuMagnitud,
                                    widgetName: kWidgetVectoresYSuMagnitud),
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
                          AppLocalizations.of(context)!.expresionComponentes,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\mathrm{v}=\langle v_1,v_2,v_3\rangle"),
                        const SizedBox(height: 50),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.magnitudVector,
                        ),
                        const SizedBox(height: 50),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.puntoInicial,
                        ),
                        const Latex(formulaText: r" P(x_1,y_1,z_1)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.puntoFinal,
                        ),
                        const Latex(formulaText: r"Q(x_2,y_2,z_2)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"|v|=\sqrt{(x_2-x_1)^2+(y_2-y_1)^2}"),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetVectoresYSuMagnitud,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetVectoresYSuMagnitud,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
