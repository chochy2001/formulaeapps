import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ModuloyArgumentoNumerosComplejos extends StatefulWidget {
  const ModuloyArgumentoNumerosComplejos({super.key});
  @override
  State<ModuloyArgumentoNumerosComplejos> createState() =>
      _ModuloyArgumentoNumerosComplejosState();
}

class _ModuloyArgumentoNumerosComplejosState
    extends State<ModuloyArgumentoNumerosComplejos> {
  bool seleccionadoMostrar = false;
  double catetoOpuesto = 0.0, catetoAdyacente = 0.0, hipotenusa = 0.0;

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
                    AppLocalizations.of(
                      context,
                    )!.moduloYArgumentoDeUnNumeroComplejo,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.moduloYArgumentoDeUnNumeroComplejo,
                          widgetName: kWidgetModuloYArgumentoDeUnNumeroComplejo,
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
                                  )!.moduloYArgumentoDeUnNumeroComplejo,
                                  widgetName:
                                      kWidgetModuloYArgumentoDeUnNumeroComplejo,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.moduloYArgumentoDeUnNumeroComplejo,
                                  widgetName:
                                      kWidgetModuloYArgumentoDeUnNumeroComplejo,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.numeroComplejo,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"z=a+bi"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.modulo),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"r=|z|=\sqrt{a^2+b^2}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.argumento,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"\theta =\tan^{-1} \frac{b}{a}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.propiedadesDelValorAbsoluto,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"|z|=0\rightarrow z=0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"|z+w|\leq |z|+|w|"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"|zw|= |z||w|"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"|z-w|\geq ||z|-|w||"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetModuloYArgumentoDeUnNumeroComplejo),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetModuloYArgumentoDeUnNumeroComplejo,
                  ),
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
                        const Latex(formulaText: r"a"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.parteReal,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"bi"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.parteImaginaria,
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
