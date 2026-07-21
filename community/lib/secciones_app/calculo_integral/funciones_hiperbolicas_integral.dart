import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FuncionesHiperbolicasIntegral extends StatefulWidget {
  const FuncionesHiperbolicasIntegral({super.key});
  @override
  State<FuncionesHiperbolicasIntegral> createState() =>
      _FuncionesHiperbolicasIntegralState();
}

class _FuncionesHiperbolicasIntegralState
    extends State<FuncionesHiperbolicasIntegral> {
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
                )!.integralesDeFuncionesTrigonometricasHiperbolicas,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                      title: AppLocalizations.of(
                        context,
                      )!.integralesDeFuncionesTrigonometricasHiperbolicas,
                      widgetName: kWidgetFuncionesHiperbolicasIntegral,
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
                              )!.integralesDeFuncionesTrigonometricasHiperbolicas,
                              widgetName: kWidgetFuncionesHiperbolicasIntegral,
                            ),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                              title: AppLocalizations.of(
                                context,
                              )!.integralesDeFuncionesTrigonometricasHiperbolicas,
                              widgetName: kWidgetFuncionesHiperbolicasIntegral,
                            ),
                          );
                        }
                      });
                    },
                  );
                },
              ),

              const SizedBox(height: 30.0),
              const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \sinh \thinspace u \space du = \thinspace csch(u)+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \cosh \thinspace u \space du = \thinspace \sinh(u)+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int sech \thinspace u \space du = \thinspace \tanh^{-1}|\sinh\space u|+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int sech^2 \thinspace u \space du = \thinspace \tanh(u)+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int sech \thinspace u \space \tanh\thinspace u\space du = -sech(u)+C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int csch \thinspace u \space du = -\coth^{-1}(\cosh\thinspace u)+ C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int csch^2 \thinspace u \space du = -\coth(u)+ C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int csch \thinspace u\thinspace \coth \thinspace u \space du = -csch(u)+ C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \tanh\thinspace u \space du = ln|\cosh \thinspace u| +C",
                    ),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                      formulaText:
                          r"\int \coth\thinspace u \space du = ln|\sinh \thinspace u| +C",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: kEspacioEntreBotones),

              const Padding(padding: EdgeInsets.only(top: 10.0)),
              const SizedBox(height: 20.0),
              //Boton para acceder al formulario en PDF
              const VerPDF(url: kWidgetFuncionesHiperbolicasIntegral),
              //Descargar PDF
              const DescargarPDF(url: kWidgetFuncionesHiperbolicasIntegral),
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
