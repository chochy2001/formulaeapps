import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FuncionesTrigonometricasIntegral extends StatefulWidget {
  const FuncionesTrigonometricasIntegral({super.key});
  @override
  State<FuncionesTrigonometricasIntegral> createState() =>
      _FuncionesTrigonometricasIntegralState();
}

class _FuncionesTrigonometricasIntegralState
    extends State<FuncionesTrigonometricasIntegral> {
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
        child: SafeArea(
          child: ListView(
            children: [
              TituloPersonalizado(
                AppLocalizations.of(
                  context,
                )!.integralesDeFuncionesTrigonometricas,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                      title: AppLocalizations.of(
                        context,
                      )!.integralesDeFuncionesTrigonometricas,
                      widgetName: kWidgetFuncionesTrigonometricasIntegral,
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
                              )!.integralesDeFuncionesTrigonometricas,
                              widgetName:
                                  kWidgetFuncionesTrigonometricasIntegral,
                            ),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                              title: AppLocalizations.of(
                                context,
                              )!.integralesDeFuncionesTrigonometricas,
                              widgetName:
                                  kWidgetFuncionesTrigonometricasIntegral,
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
                    Latex(
                      formulaText:
                          r"\int \sin\thinspace u\space du = -\cos\thinspace u + C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \cos\thinspace u\space du = \sin\thinspace u + C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \sec\thinspace u \cdot \tan\thinspace u \thinspace du =\frac{1}{\cos\thinspace u}+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \sec^2u\space du = \tan\thinspace u+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \csc^2\thinspace u\thinspace du = \cot\thinspace u +C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int (\sec \thinspace u \cdot \tan\thinspace u)\space du = \sec\thinspace u +C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int(\csc\thinspace u \cdot \cot\thinspace u)du = \sec\thinspace u +C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int u\cdot \sin\space u\space du = \sin\thinspace u - u\cdot \cos\thinspace u + C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int u\cdot \cos\thinspace u\space du = \cos\thinspace u + u\cdot \sin\thinspace u+ C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
              const SizedBox(height: kEspacioEntreBotones),

              const Padding(padding: EdgeInsets.only(top: 10.0)),
              const SizedBox(height: 20.0),
              //Boton para acceder al formulario en PDF
              const VerPDF(url: kWidgetFuncionesTrigonometricasIntegral),
              //Descargar PDF
              const DescargarPDF(url: kWidgetFuncionesTrigonometricasIntegral),

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
                    const Latex(formulaText: r"\sin"),
                    TextoEcuaciones(AppLocalizations.of(context)!.seno),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\cos"),
                    TextoEcuaciones(AppLocalizations.of(context)!.coseno),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\tan"),
                    TextoEcuaciones(AppLocalizations.of(context)!.tangente),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\csc"),
                    TextoEcuaciones(AppLocalizations.of(context)!.cosecante),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\sec"),
                    TextoEcuaciones(AppLocalizations.of(context)!.secante),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\cot"),
                    TextoEcuaciones(AppLocalizations.of(context)!.cotangente),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\frac{du}{dx} = u^{'}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const SizedBox(height: kEspacioEntreBotones),
                    const CapdesisLatex(),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
