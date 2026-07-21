import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class IdentidadesHiperbolicasGenerales extends StatefulWidget {
  const IdentidadesHiperbolicasGenerales({super.key});
  @override
  State<IdentidadesHiperbolicasGenerales> createState() =>
      _IdentidadesHiperbolicasGeneralesState();
}

class _IdentidadesHiperbolicasGeneralesState
    extends State<IdentidadesHiperbolicasGenerales> {
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
        child: ListView(
          children: [
            TituloPersonalizado(
              AppLocalizations.of(context)!.identidadesHiperbolicas,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.identidadesHiperbolicas,
                    widgetName: kWidgetIdentidadesHiperbolicasGenerales,
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
                            )!.identidadesHiperbolicas,
                            widgetName: kWidgetIdentidadesHiperbolicasGenerales,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.identidadesHiperbolicas,
                            widgetName: kWidgetIdentidadesHiperbolicasGenerales,
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
                    formulaText: r"\cosh\thinspace(-x) = \cosh\thinspace x",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1- \tanh{^2}\thinspace = sech{^2}\thinspace x",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tanh(-x) = -\tanh\thinspace  x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sinh (-x) = -\sinh\thinspace x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\cosh\thinspace x - \sinh\thinspace x = e^{-x}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\cosh^2 \thinspace x \thinspace -\thinspace \sinh^2\thinspace x = 1",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\sinh (2x) = 2\sinh\thinspace x \cdot \cosh\thinspace x",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\sinh (x \pm y) = \sinh\thinspace x \cdot \cosh\thinspace y \pm \cosh\thinspace x \cdot \sinh \thinspace y",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\cosh (x \pm y) = \cosh\thinspace x \cdot \cosh\thinspace y \pm \sinh\thinspace x \cdot \sinh \thinspace y",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetIdentidadesHiperbolicasGenerales),

            //Descargar PDF
            const DescargarPDF(url: kWidgetIdentidadesHiperbolicasGenerales),

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
                  const Latex(formulaText: r"\sinh "),
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
                  const Latex(formulaText: r"sech"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.secanteHiperbolica,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"csch"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cosecanteHiperbolica,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\coth "),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cotangenteHiperbolica,
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
    );
  }
}
