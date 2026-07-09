import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TrigonometricasInversasIntegral extends StatefulWidget {
  @override
  _TrigonometricasInversasIntegralState createState() =>
      _TrigonometricasInversasIntegralState();
}

class _TrigonometricasInversasIntegralState
    extends State<TrigonometricasInversasIntegral> {
  bool seleccionadoMostrar = true;

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
        child: SafeArea(
          child: ListView(
            children: [
              TituloPersonalizado(
                AppLocalizations.of(context)!
                    .integralesDeFuncionesTrigonometricasInversas,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                        title: AppLocalizations.of(context)!
                            .integralesDeFuncionesTrigonometricasInversas,
                        widgetName: kWidgetTrigonometricasInversasIntegral),
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
                                    .integralesDeFuncionesTrigonometricasInversas,
                                widgetName:
                                    kWidgetTrigonometricasInversasIntegral),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                                title: AppLocalizations.of(context)!
                                    .integralesDeFuncionesTrigonometricasInversas,
                                widgetName:
                                    kWidgetTrigonometricasInversasIntegral),
                          );
                        }
                      });
                    },
                  );
                },
              ),

              const SizedBox(
                height: 40.0,
              ),
              const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \sin^{-1} \thinspace u \space du = u\cdot \sin^{-1}(u)+\sqrt{1-u^2}+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \csc^{-1} \thinspace u \space du = u\cdot \csc^{-1}(u)+ln(u+\sqrt{u^2-1})+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \cos^{-1} \thinspace u \space du = u\cdot \cos^{-1}(u)-\sqrt{1-u^2}+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \sec^{-1} \thinspace u \space du = u\cdot \sec^{-1}(u)-ln(u+\sqrt{u^2-1})+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \tan^{-1} \thinspace u \space du = u\cdot \tan^{-1}(u)-\frac{1}{2}\thinspace ln(1+u^2)+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \cot^{-1} \thinspace u \space du = u\cdot \cot^{-1}(u)+\frac{1}{2}\thinspace ln(1+u^2)+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
              //Boton para acceder al formulario en PDF
              const VerPDF(
                url: kWidgetTrigonometricasInversasIntegral,
              ),
              //Descargar PDF
              const DescargarPDF(
                url: kWidgetTrigonometricasInversasIntegral,
              ),

              Container(
                decoration: BoxDecoration(
                  color: kColorBotones,
                  border: Border.all(
                    color: kColorFondo,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Notas(),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\sin"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.seno,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\cos"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.coseno,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\tan"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.tangente,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\csc"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.cosecante,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\sec"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.secante,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\cot"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.cotangente,
                    ),
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
