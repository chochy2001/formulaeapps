import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ElipseConCentroDiferenteDelOrigen extends StatefulWidget {
  @override
  _ElipseConCentroDiferenteDelOrigenState createState() =>
      _ElipseConCentroDiferenteDelOrigenState();
}

class _ElipseConCentroDiferenteDelOrigenState
    extends State<ElipseConCentroDiferenteDelOrigen> {
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
                        .elipseConCentroDiferenteDelOrigen,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .elipseConCentroDiferenteDelOrigen,
                            widgetName:
                                kWidgetElipseConCentroDiferenteDelOrigen),
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
                                        .elipseConCentroDiferenteDelOrigen,
                                    widgetName:
                                        kWidgetElipseConCentroDiferenteDelOrigen),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .elipseConCentroDiferenteDelOrigen,
                                    widgetName:
                                        kWidgetElipseConCentroDiferenteDelOrigen),
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .centroDiferenteOrigenEjeFocalX,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{(x-h)^2}{a^2}+\frac{(y-k)^2}{b^2} = 1"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"F(h+c,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"F'(h-c,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"V(h+a,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"V'(h-a,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"B(h,k+b)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"B'(h,k-b)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"R(h+c,k-b^2/a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"R'(h-c,k-b^2/a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L(h+c,k+b^2/a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L'(h-c,k+b^2/a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.centroOrigenEjeFocalY,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{(x-h)^2}{b^2}+\frac{(y-k)^2}{a^2} = 1"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"F(h,k+c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"F'(h,k-c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"V(h,k+a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"V'(h,k-a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"B(h+b,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"B'(h-b,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"R(h+b^2/a,k+c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"R'(h+b^2/a,k-c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L(h-b^2/a,k+c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L'(h-b^2/a,k-c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetElipseConCentroDiferenteDelOrigen,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetElipseConCentroDiferenteDelOrigen,
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
