import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class DerivadaFuncionesVectoriales extends StatefulWidget {
  @override
  _DerivadaFuncionesVectorialesState createState() =>
      _DerivadaFuncionesVectorialesState();
}

class _DerivadaFuncionesVectorialesState
    extends State<DerivadaFuncionesVectoriales> {
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
        child: ListView(
          children: [
            TituloPersonalizado(
              AppLocalizations.of(context)!.derivadasFuncionesVectoriales,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .derivadasFuncionesVectoriales,
                      widgetName: kWidgetDerivadaFuncionesVectoriales),
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
                                  .derivadasFuncionesVectoriales,
                              widgetName: kWidgetDerivadaFuncionesVectoriales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .derivadasFuncionesVectoriales,
                              widgetName: kWidgetDerivadaFuncionesVectoriales),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 20.0,
            ),
            const ZoomPersonalizado(
              child: Column(
                children: [
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{d}{dt}\mathbf{C} = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\frac{d}{dt}[c\mathbf{u}(t)] = c\mathbf{u}'(t)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\frac{d}{dt}[f(t)\mathbf{u}(t)] = f'(t)\mathbf{u}(t)+f(t)\mathbf{u}'(t)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\frac{d}{dt}[\mathbf{u}(t)\pm\mathbf{v}(t)] = \mathbf{u}'(t)\pm\mathbf{v}'(t)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\frac{d}{dt}[\mathbf{u}(t)\cdot\mathbf{v}(t)] = \mathbf{u}'(t)\cdot\mathbf{v}(t)+\mathbf{u}(t)\cdot\mathbf{v}'(t)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\frac{d}{dt}[\mathbf{u}(t)\times\mathbf{v}(t)] = \mathbf{u}'(t)\times\mathbf{v}(t)+\mathbf{u}(t)\times\mathbf{v}'(t)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\frac{d}{dt}[\mathbf{u}(f(t))] = f'(t)\mathbf{u}'(f(t))"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetDerivadaFuncionesVectoriales,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetDerivadaFuncionesVectoriales,
            ),
            const SizedBox(
              height: 20.0,
            ),
            //Notas
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
                  const Latex(formulaText: r"\mathbf{u}, \mathbf{v}"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .funcionesVectorialesDiferenciablesDeT,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\mathbf{C}"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.unVectorConstante,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Latex(formulaText: r"c"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.escalar,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"f"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.unaFuncionEscalarDerivable,
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
