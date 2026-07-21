import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class AnguloEntreVectores extends StatefulWidget {
  const AnguloEntreVectores({super.key});
  @override
  State<AnguloEntreVectores> createState() => _AnguloEntreVectoresState();
}

class _AnguloEntreVectoresState extends State<AnguloEntreVectores> {
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
                    AppLocalizations.of(context)!.anguloEntreVectores,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.anguloEntreVectores,
                          widgetName: kWidgetAnguloEntreVectores,
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
                                  )!.anguloEntreVectores,
                                  widgetName: kWidgetAnguloEntreVectores,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.anguloEntreVectores,
                                  widgetName: kWidgetAnguloEntreVectores,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextoEcuaciones(AppLocalizations.of(context)!.sean),
                        const Latex(
                          formulaText:
                              r"u = \langle u_1,u_2,u_3 \rangle,\space v = \langle v_1,v_2,v_3 \rangle",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\theta = cos^{-1}\left( \frac{u_1v_1+u_2v_2+u_3v_3}{|u||v|}\right)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetAnguloEntreVectores),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetAnguloEntreVectores),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
