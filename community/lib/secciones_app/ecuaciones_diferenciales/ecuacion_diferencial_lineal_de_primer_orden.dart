import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class EcuacionDiferencialLinealDePrimerOrden extends StatefulWidget {
  const EcuacionDiferencialLinealDePrimerOrden({super.key});
  @override
  State<EcuacionDiferencialLinealDePrimerOrden> createState() =>
      _EcuacionDiferencialLinealDePrimerOrdenState();
}

class _EcuacionDiferencialLinealDePrimerOrdenState
    extends State<EcuacionDiferencialLinealDePrimerOrden> {
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!
                        .ecuacionDiferencialLinealPrimerOrden,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .ecuacionDiferencialLinealPrimerOrden,
                            widgetName:
                                kWidgetEcuacionDiferencialLinealDePrimerOrden),
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
                                        .ecuacionDiferencialLinealPrimerOrden,
                                    widgetName:
                                        kWidgetEcuacionDiferencialLinealDePrimerOrden),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .ecuacionDiferencialLinealPrimerOrden,
                                    widgetName:
                                        kWidgetEcuacionDiferencialLinealDePrimerOrden),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{dy}{dx}+\mathrm{P}(x)y = \mathrm{Q}(x)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"y = e^{-\int \mathrm{P}(x)dx}\left[\int e^{\int \mathrm{P}(x)dx}\mathrm{Q}(x)dx + \mathrm{C}\right]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .ecuacionDiferencialReducibleALineal,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"\frac{dy}{dx}+\mathrm{P}(x)y = \mathrm{Q}(x)y^n"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .ecuacionDiferencialReducidaALineal,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"\frac{dz}{dx}+\mathrm{P_1}(x)z = \mathrm{Q_1}(x)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.donde,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"\mathrm{P_1}(x) = (1-n)\mathrm{P}(x)"),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"\mathrm{Q_1}(x) = (1-n)\mathrm{Q}(x)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"z=e^{\int \mathrm{P_1}(x)dx}\left[\int e^{\int \mathrm{P_1}(x)dx}\mathrm{Q_1}(x)dx+\mathrm{C}\right]"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .seRegresanLosValoresOriginalesAZ,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetEcuacionDiferencialLinealDePrimerOrden,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetEcuacionDiferencialLinealDePrimerOrden,
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
                        const Latex(formulaText: r"P, Q "),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .funcionesDeXSePonenConSuRespectivoSigno,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.seHaceLaSustitucionDe,
                        ),
                        const SizedBox(height: 5),
                        const Latex(formulaText: r"z = y^{1-n}"),
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
