import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class AnalogiasDeNeper extends StatefulWidget {
  const AnalogiasDeNeper({super.key});
  @override
  State<AnalogiasDeNeper> createState() => _AnalogiasDeNeperState();
}

class _AnalogiasDeNeperState extends State<AnalogiasDeNeper> {
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
                    AppLocalizations.of(context)!.analogiasDeNeper,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(context)!.analogiasDeNeper,
                          widgetName: kWidgetAnalogiasDeNeper,
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
                                  )!.analogiasDeNeper,
                                  widgetName: kWidgetAnalogiasDeNeper,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.analogiasDeNeper,
                                  widgetName: kWidgetAnalogiasDeNeper,
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
                        Latex(
                          formulaText:
                              r"\tan\frac{\alpha+\beta}{2} = \frac{\cos\frac{a-b}{2}}{\cos\frac{a+b}{2}}\cot\frac{\gamma}{2}",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\tan\frac{\alpha-\beta}{2} = \frac{\sin\frac{a-b}{2}}{\sin\frac{a+b}{2}}\cot\frac{\gamma}{2}",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\tan\frac{a+b}{2} = \frac{\cos\frac{\alpha-\beta}{2}}{\cos\frac{\alpha+\beta}{2}}\tan\frac{c}{2}",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\tan\frac{a-b}{2} = \frac{\sin\frac{\alpha-\beta}{2}}{\sin\frac{\alpha+\beta}{2}}\tan\frac{c}{2}",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetAnalogiasDeNeper),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetAnalogiasDeNeper),

                  //Notas
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(color: kColorFondo, width: 8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a,b,c"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.ladosTrianguloEsferico,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\alpha,\beta,\gamma"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.angulosTrianguloEsferico,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
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
