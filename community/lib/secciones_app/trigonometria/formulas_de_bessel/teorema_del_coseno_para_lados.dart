import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TeoremaDelCosenoParaLados extends StatefulWidget {
  const TeoremaDelCosenoParaLados({super.key});
  @override
  State<TeoremaDelCosenoParaLados> createState() =>
      _TeoremaDelCosenoParaLadosState();
}

class _TeoremaDelCosenoParaLadosState extends State<TeoremaDelCosenoParaLados> {
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
                    AppLocalizations.of(context)!.teoremaDelCosenoParaLados,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.teoremaDelCosenoParaLados,
                          widgetName: kWidgetTeoremaDelCosenoParaLados,
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
                                  )!.teoremaDelCosenoParaLados,
                                  widgetName: kWidgetTeoremaDelCosenoParaLados,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.teoremaDelCosenoParaLados,
                                  widgetName: kWidgetTeoremaDelCosenoParaLados,
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
                        Latex(
                          formulaText:
                              r"\cos a = \cos b \cos c + \sin b \sin c \cos \alpha",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cos b = \cos a \cos c + \sin a \sin c \cos \beta",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cos c = \cos a \cos b + \sin a \sin b \cos \gamma",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetTeoremaDelCosenoParaLados),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetTeoremaDelCosenoParaLados),
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
