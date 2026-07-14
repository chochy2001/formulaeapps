import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class PropiedadesLimites extends StatefulWidget {
  const PropiedadesLimites({super.key});
  @override
  State<PropiedadesLimites> createState() => _PropiedadesLimitesState();
}

class _PropiedadesLimitesState extends State<PropiedadesLimites> {
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
            Column(
              children: [
                //Propiedades de los limites
                TituloPersonalizado(
                  AppLocalizations.of(context)!.propiedadesDeLosLimites,
                ),
                adContainer,
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                          title: AppLocalizations.of(context)!
                              .propiedadesDeLosLimites,
                          widgetName: kWidgetPropiedadesLimites),
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
                                      .propiedadesDeLosLimites,
                                  widgetName: kWidgetPropiedadesLimites),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                  title: AppLocalizations.of(context)!
                                      .propiedadesDeLosLimites,
                                  widgetName: kWidgetPropiedadesLimites),
                            );
                          }
                        });
                      },
                    );
                  },
                ),

                const SizedBox(height: kEspacioEntreBotones),
                const ZoomPersonalizado(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Latex(formulaText: r"\lim_{x \to c}k=k"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to c}k\cdot f(x)=k\cdot\lim_{x \to c}f(x)"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to c}[f(x)\pm g(x)]=\lim_{x \to c}f(x)\pm\lim_{x \to c}g(x)"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to c}[f(x)\cdot g(x)] = \lim_{x \to c}f(x)\cdot\lim_{x \to c}g(x)"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to c}\frac{f(x)}{g(x)} =  \frac{\lim_{x \to c}f(x)}{\lim_{x \to c}g(x)}"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x\to c}[f(x)^{g(x)}]=\lim_{x\to c}f(x)^{\lim_{x\to c}g(x)}"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x\to c}\log \cdot f(x) =\log\cdot \lim_{x\to c}f(x)"),

                      SizedBox(height: 70),
                      //Limites laterales
                      TextoEcuaciones('Límites Laterales'),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to c}f(x)=L \space\space\mathsf{Si\space y\space solo\space si}"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to c^-}f(x)=L"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to c^+}f(x)=L"),

                      SizedBox(height: 70),

                      //Limites al infinito

                      TextoEcuaciones('Límites al infinito'),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to +\infty}\frac{k}{x^n} = 0"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to -\infty}\frac{k}{x^n} = 0"),

                      SizedBox(
                        height: 40.0,
                      ),
                    ],
                  ),
                ),

                //Boton para acceder al formulario en PDF
                const VerPDF(
                  url: kWidgetPropiedadesLimites,
                ),
                //Descargar PDF
                const DescargarPDF(
                  url: kWidgetPropiedadesLimites,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
