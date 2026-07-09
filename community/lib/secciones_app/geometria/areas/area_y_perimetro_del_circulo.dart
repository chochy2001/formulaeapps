import 'package:flutter/material.dart';
import 'dart:math';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class AreaYPerimetroDelCirculo extends StatefulWidget {
  @override
  _AreaYPerimetroDelCirculoState createState() =>
      _AreaYPerimetroDelCirculoState();
}

class _AreaYPerimetroDelCirculoState extends State<AreaYPerimetroDelCirculo> {
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

  double radio = 0.0;

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
                    AppLocalizations.of(context)!.areaPerimetroCirculo,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .areaPerimetroCirculo,
                            widgetName: kWidgetAreaYPerimetroDelCirculo),
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
                                        .areaPerimetroCirculo,
                                    widgetName:
                                        kWidgetAreaYPerimetroDelCirculo),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .areaPerimetroCirculo,
                                    widgetName:
                                        kWidgetAreaYPerimetroDelCirculo),
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
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.area,
                      ),
                      const Latex(formulaText: r"\pi r^2"),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.perimetro,
                      ),
                      const Latex(formulaText: r"2\pi r = \pi d"),
                      const SizedBox(height: kEspacioEntreBotones),
                    ],
                  ),
                  const ZoomImagePersonalizado(
                      urlImagen: kUrlImagenAreaYPerimetrosDelCirculo),
                  const SizedBox(height: kEspacioInteractivo * 3),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.radio,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            radio = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  _solucionCirculo(radio),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetAreaYPerimetroDelCirculo,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetAreaYPerimetroDelCirculo,
                  ),
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
                        const SizedBox(
                          height: 10.0,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.pi,
                        ),
                        const Latex(formulaText: r"\pi"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.radio,
                        ),
                        const Latex(formulaText: r"r"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.diametro,
                        ),
                        const Latex(formulaText: r"d"),
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

  Widget _solucionCirculo(radio) {
    double areaCirculo = (pi) * (pow(radio, 2));
    double perimetroCirculo = 2 * pi * radio;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(
          width: 10.0,
          color: kColorFondo,
        ),
      ),
      child: ListTile(
        title: Text(
          '${AppLocalizations.of(context)!.areaCirculo}= ${implementFraction(areaCirculo)}\n${AppLocalizations.of(context)!.perimetroCirculo}= ${implementFraction(perimetroCirculo)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }
}
