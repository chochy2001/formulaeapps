import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class OperacionesConPolinomios extends StatefulWidget {
  const OperacionesConPolinomios({super.key});
  @override
  State<OperacionesConPolinomios> createState() =>
      _OperacionesConPolinomiosState();
}

class _OperacionesConPolinomiosState extends State<OperacionesConPolinomios> {
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
                    AppLocalizations.of(context)!.operacionesPolinomios,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.operacionesPolinomios,
                          widgetName: kWidgetOperacionesPolinomios,
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
                                  )!.operacionesPolinomios,
                                  widgetName: kWidgetOperacionesPolinomios,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.operacionesPolinomios,
                                  widgetName: kWidgetOperacionesPolinomios,
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
                        //Suma
                        TextoEcuaciones(AppLocalizations.of(context)!.adicion),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a+b"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Resta
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sustraccion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a+(-b)=a-b"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Multiplicacion
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.multiplicacion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a(b+c+...+z)=ab+ac+...+az"),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(a+b)(c+d)=ac+ad+bc+bd"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //División
                        TextoEcuaciones(AppLocalizations.of(context)!.division),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\frac{a}{b}"),

                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetOperacionesPolinomios),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetOperacionesPolinomios),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
