import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class EcuacionesLineales extends StatefulWidget {
  const EcuacionesLineales({super.key});
  @override
  State<EcuacionesLineales> createState() => _EcuacionesLinealesState();
}

class _EcuacionesLinealesState extends State<EcuacionesLineales> {
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
                    AppLocalizations.of(context)!.ecuacionesLineales,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.ecuacionesLineales,
                          widgetName: kWidgetEcuacionesLineales,
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
                                  )!.ecuacionesLineales,
                                  widgetName: kWidgetEcuacionesLineales,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.ecuacionesLineales,
                                  widgetName: kWidgetEcuacionesLineales,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.propiedadAditivaDeLaIgualdad,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a=b\rightarrow a+c=b+c"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.propiedadMultiplicativaDeLaIgualdad,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a=b\rightarrow ac=bc"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.ecuacionesConValorAbsoluto,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Column(
                          children: [
                            Latex(formulaText: r"|ax+b|=c"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"ax+b=c"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"ax+b=-c"),
                            SizedBox(height: kEspacioEntreBotones),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetEcuacionesLineales),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetEcuacionesLineales),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
