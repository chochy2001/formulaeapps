import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TrigonometricasHiperbolicasDiferencial extends StatefulWidget {
  @override
  _TrigonometricasHiperbolicasDiferencialState createState() =>
      _TrigonometricasHiperbolicasDiferencialState();
}

class _TrigonometricasHiperbolicasDiferencialState
    extends State<TrigonometricasHiperbolicasDiferencial> {
  bool seleccionadoDX = false;
  bool seleccionadoU = true;

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
                    .derivadasDeFuncionesTrigonometriasHiperbolicas,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                        title: AppLocalizations.of(context)!
                            .derivadasDeFuncionesTrigonometriasHiperbolicas,
                        widgetName: kWidgetFuncionesHiperbolicas),
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
                                    .derivadasDeFuncionesTrigonometriasHiperbolicas,
                                widgetName: kWidgetFuncionesHiperbolicas),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                                title: AppLocalizations.of(context)!
                                    .derivadasDeFuncionesTrigonometriasHiperbolicas,
                                widgetName: kWidgetFuncionesHiperbolicas),
                          );
                        }
                      });
                    },
                  );
                },
              ),

              //Derivación u
              const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(\sinh\thinspace u) = \cosh\thinspace u u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(\cosh\thinspace u) = -\sinh\thinspace u u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(\tanh\thinspace u) = sech{^2}\thinspace u u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(csch\thinspace u) = -csch\thinspace u \cdot \cot\thinspace uu'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(sech\thinspace u) = sech\thinspace u \cdot \tanh\thinspace uu'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(\coth\thinspace u) = -csch{^2}\thinspace u u'"),

                    //Boton para acceder al formulario en PDF
                    SizedBox(height: kEspacioEntreBotones),
                    VerPDF(
                      url: kWidgetFuncionesHiperbolicas,
                    ),
                    //Descargar PDF
                    DescargarPDF(
                      url: kWidgetFuncionesHiperbolicas,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kEspacioEntreBotones,
              ),

              const SizedBox(
                height: 30.0,
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
                    const Latex(formulaText: r"\sinh"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.senoHiperbolico,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\cosh"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.cosenoHiperbolico,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\tanh"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.tangenteHiperbolica,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"csch"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.cosecanteHiperbolica,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"sech"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.secanteHiperbolica,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\coth"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.cotangenteHiperbolica,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\frac{du}{dx} = u^{'}"),
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
