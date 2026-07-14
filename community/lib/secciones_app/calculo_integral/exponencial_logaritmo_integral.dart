import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ExponencialyLogaritmoIntegral extends StatefulWidget {
  const ExponencialyLogaritmoIntegral({super.key});
  @override
  State<ExponencialyLogaritmoIntegral> createState() =>
      _ExponencialyLogaritmoIntegralState();
}

class _ExponencialyLogaritmoIntegralState
    extends State<ExponencialyLogaritmoIntegral> {
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
                    .integralesDelExponencialYLogaritmos,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                        title: AppLocalizations.of(context)!
                            .integralesDelExponencialYLogaritmos,
                        widgetName: kWidgetExponencialLogaritmoIntegral),
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
                                    .integralesDelExponencialYLogaritmos,
                                widgetName:
                                    kWidgetExponencialLogaritmoIntegral),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                                title: AppLocalizations.of(context)!
                                    .integralesDelExponencialYLogaritmos,
                                widgetName:
                                    kWidgetExponencialLogaritmoIntegral),
                          );
                        }
                      });
                    },
                  );
                },
              ),

              const SizedBox(
                height: 30.0,
              ),
              const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(formulaText: r"\int e^u\space du = e^u+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int a^u\space du = \frac{a^u}{ln|a|}+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int u\thinspace a^u\space du = \frac{a^u}{ln|a|}\left(u-\frac{1}{ln|a|}\right)+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int u\thinspace e^u\space du = (u-1)e^u+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int e^{au}\sin(bu)\thinspace du = \frac{e^{(au)}}{a^2+b^2}(a\thinspace \sin(bu)-b\cos(bu))+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int e^{au}\cos(bu)\thinspace du = \frac{e^{(au)}}{a^2+b^2}(a\thinspace \cos(bu)+b\sin(bu))+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int ln\thinspace u\space du = u\thinspace ln(u) - u + C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \frac{1}{u\thinspace ln(u)}du = ln|ln(u)|+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int log_au\thinspace du = \frac{1}{ln|a|}(u\space ln|u|-u)=\frac{u}{ln|a|}(ln\thinspace u-1)+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int ulog_au\thinspace du = \frac{u^2}{4}(2log_au-1)+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int u\thinspace ln|u| \space du = \frac{u^2}{4}(2ln|u|-1)+C"),
                    SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),

              const SizedBox(
                height: kEspacioEntreBotones,
              ),

              const Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              //Boton para acceder al formulario en PDF
              const VerPDF(
                url: kWidgetExponencialLogaritmoIntegral,
              ),
              //Descargar PDF
              const DescargarPDF(
                url: kWidgetExponencialLogaritmoIntegral,
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
                    const Latex(formulaText: r"ln(u) = log_e(u)"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"ln(x) = \int_1 ^x \frac{dt}{t},\space x>0"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.logaritmoNaturalDefinicion,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"e \thickapprox 2,71828"),
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
