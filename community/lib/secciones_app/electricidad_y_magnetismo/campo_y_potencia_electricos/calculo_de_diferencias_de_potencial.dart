import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class CalculoDeDiferenciasDePotencial extends StatefulWidget {
  const CalculoDeDiferenciasDePotencial({super.key});
  @override
  State<CalculoDeDiferenciasDePotencial> createState() =>
      _CalculoDeDiferenciasDePotencialState();
}

class _CalculoDeDiferenciasDePotencialState
    extends State<CalculoDeDiferenciasDePotencial> {
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
              AppLocalizations.of(context)!.calculoDiferenciasPotencial,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.calculoDiferenciasPotencial,
                    widgetName: kWidgetCalculoDeDiferenciasDePotencial,
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
                            )!.calculoDiferenciasPotencial,
                            widgetName: kWidgetCalculoDeDiferenciasDePotencial,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.calculoDiferenciasPotencial,
                            widgetName: kWidgetCalculoDeDiferenciasDePotencial,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.diferenciaDePotencial,
                  ),
                  const Latex(
                    formulaText:
                        r"V_{AB} = - \int_{B}^{A} \vec{E} \cdot d\vec{l}",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(AppLocalizations.of(context)!.cargaPuntual),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(AppLocalizations.of(context)!.campoElectrico),
                  const Latex(
                    formulaText: r"\vec{E} = k \frac{q}{r^2} \hat{r}",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.diferenciaDePotencial,
                  ),
                  const Latex(
                    formulaText:
                        r"V_{AB} = - \int_{rB}^{rA} k \frac{q}{r^2} \hat{r} \cdot d\vec{r}",
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"V_{AB} = kq\left( \frac{1}{r_A} - \frac{1}{r_B}\right)",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(AppLocalizations.of(context)!.lineaInfinita),
                  TextoEcuaciones(AppLocalizations.of(context)!.campoElectrico),
                  const Latex(
                    formulaText: r"\vec{E} =  \frac{2k\lambda}{r} \hat{r}",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.diferenciaDePotencial,
                  ),
                  const Latex(
                    formulaText:
                        r"V_{AB} = - \int_{rB}^{rA} \frac{2k\lambda}{r} \hat{r} \cdot d\vec{r}",
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"V_{AB} = 2k\lambda \ln\left( \frac{r_B}{r_A} \right)",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.superficieInfinita,
                  ),
                  TextoEcuaciones(AppLocalizations.of(context)!.campoElectrico),
                  const Latex(
                    formulaText:
                        r"\vec{E} =  \frac{\sigma}{2 \varepsilon _0 } \hat{r}",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.diferenciaDePotencial,
                  ),
                  const Latex(
                    formulaText:
                        r"V_{AB} = - \int_{rB}^{rA} \frac{\sigma}{2\varepsilon _0} \hat{r} \cdot d\vec{r}",
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"V_{AB} = \frac{\sigma}{2\varepsilon _0} \left( r_B - r_A \right)",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.placasConductoras,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(AppLocalizations.of(context)!.campoElectrico),
                  const Latex(
                    formulaText:
                        r"\vec{E} =  -\frac{\sigma}{\varepsilon _0 } \hat{r}",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.diferenciaDePotencial,
                  ),
                  const Latex(
                    formulaText:
                        r"V_{AB} = - \int_{rB}^{rA} \frac{\sigma}{\varepsilon _0} \hat{r} \cdot d\vec{r}",
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"V_{AB} = \frac{\sigma}{\varepsilon _0} \left( r_A - r_B \right)",
                  ),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetCalculoDeDiferenciasDePotencial),
            //Descargar PDF
            const DescargarPDF(url: kWidgetCalculoDeDiferenciasDePotencial),
          ],
        ),
      ),
    );
  }
}
