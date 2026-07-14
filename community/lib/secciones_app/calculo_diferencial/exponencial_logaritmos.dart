import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ExponencialyLogaritmosDiferencial extends StatefulWidget {
  const ExponencialyLogaritmosDiferencial({super.key});
  @override
  State<ExponencialyLogaritmosDiferencial> createState() =>
      _ExponencialyLogaritmosDiferencialState();
}

class _ExponencialyLogaritmosDiferencialState
    extends State<ExponencialyLogaritmosDiferencial> {
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
                    .derivadasDeFuncionesExponencialYLogaritmos,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                        title: AppLocalizations.of(context)!
                            .derivadasDeFuncionesExponencialYLogaritmos,
                        widgetName: kWidgetExponencialLogaritmos),
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
                                    .derivadasDeFuncionesExponencialYLogaritmos,
                                widgetName: kWidgetExponencialLogaritmos),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                                title: AppLocalizations.of(context)!
                                    .derivadasDeFuncionesExponencialYLogaritmos,
                                widgetName: kWidgetExponencialLogaritmos),
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
                    Latex(formulaText: r"\frac{d}{dx}(a^u) = a^u ln(a) u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(formulaText: r"\frac{d}{dx}(e^u) = e^u u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(u^v) = vu^{v-1} u' + ln(u)u^v v'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(ln\space u) =\frac{u'}{u} = \frac{1}{u}u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(log\space u) = \frac{log\thinspace e}{u}u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(log_a\thinspace u) = \frac{log_a\thinspace e}{u}u'\space\space\space\space a > 0,\space\space\space a\neq 1"),

                    SizedBox(height: kEspacioEntreBotones),
                    //Boton para acceder al formulario en PDF
                    VerPDF(
                      url: kWidgetExponencialLogaritmos,
                    ),
                    //Descargar PDF
                    DescargarPDF(
                      url: kWidgetExponencialLogaritmos,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kEspacioEntreBotones,
              ),
              const SizedBox(
                height: 20.0,
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
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.explicacionLogaritmo,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText: r"\log_a{x} = y\rightarrow a^y = x"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText: r"3^2 = 9 \rightarrow \log_3{9} = 2"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"e \thickapprox 2,71828"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\frac{du}{dx} = u^{'}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r""),
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
