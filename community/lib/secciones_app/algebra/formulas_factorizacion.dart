import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FormulasDeFactorizacion extends StatefulWidget {
  const FormulasDeFactorizacion({super.key});
  @override
  State<FormulasDeFactorizacion> createState() =>
      _FormulasDeFactorizacionState();
}

class _FormulasDeFactorizacionState extends State<FormulasDeFactorizacion> {
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
                    AppLocalizations.of(context)!.formulasFactorizacion,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .formulasFactorizacion,
                            widgetName: kWidgetFormulasDeFactorizacion),
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
                                        .formulasFactorizacion,
                                    widgetName: kWidgetFormulasDeFactorizacion),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .formulasFactorizacion,
                                    widgetName: kWidgetFormulasDeFactorizacion),
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

                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        Latex(formulaText: r"na+nb=n(a+b)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a^2+2ab+b^2=(a+b)^2"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a^2+b^2=(a+b)^2-2ab =(a-b)^2+2ab"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a^2-b^2=(a+b)(a-b)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"a^3+b^3=(a+b)(a^2-ab+b^2)=(a+b)^3-3ab(a+b)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"a^3-b^3=(a-b)(a^2+ab+b^2)=(a-b)^3+3ab(a-b)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"a^3+b^3+c^3-3abc=(a+b+c)(a^2+b^2+c^2-ab-bc-ca)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a^4+b^4=(a+b)(a-b)[(a+b)^2-2ab]"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"ax+ay+bx+by=(a+b)(x+y)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"x^2+bx+c=x^2+(m+n)x+mn"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"m+n=b"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"mn=c"),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetFormulasDeFactorizacion,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetFormulasDeFactorizacion,
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
