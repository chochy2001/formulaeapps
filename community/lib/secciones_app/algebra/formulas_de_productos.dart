import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FormulasDeProductos extends StatefulWidget {
  @override
  _FormulasDeProductosState createState() => _FormulasDeProductosState();
}

class _FormulasDeProductosState extends State<FormulasDeProductos> {
  bool seleccionadoMostrar = false;
  double catetoOpuesto = 0.0, catetoAdyacente = 0.0, hipotenusa = 0.0;

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
                    AppLocalizations.of(context)!.formulaProductos,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title:
                                AppLocalizations.of(context)!.formulaProductos,
                            widgetName: kWidgetFormulasDeProductos),
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
                                        .formulaProductos,
                                    widgetName: kWidgetFormulasDeProductos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .formulaProductos,
                                    widgetName: kWidgetFormulasDeProductos),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        const Latex(
                            formulaText: r"(a+b)^2=a^2+2ab+b^2=(a-b)^2+4ab"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"(a-b)^2=a^2-2ab+b^2=(a+b)^2-4ab"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"(a+b)^3=a^3+3a^2+3ab^2+b^3 =(a+b)(a^2+2ab+b^2)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(a+b)^2-(a-b)^2=4ab"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(a+b)(a+c)=a^2+ab+ac+bc"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(a+b)(a-b)=a^2-b^2"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"2(a^2+b^2)=(a+b)^2+(a-b)^2"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"(a+b+c)^2=a^2+b^2+c^2+2ab+2bc+2ca"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"(a+b-c)^2=a^2+b^2+c^2+2ab-2bc-2ca"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"(a-b-c)^2=a^2+b^2+c^2-2ab+2bc-2ca"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetFormulasDeProductos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetFormulasDeProductos,
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
