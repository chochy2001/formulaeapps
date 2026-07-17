import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';

import '../../../../constantes/export_constantes.dart';

class EcuacionesDeSegundoGrado extends StatefulWidget {
  const EcuacionesDeSegundoGrado({super.key});
  @override
  State<EcuacionesDeSegundoGrado> createState() =>
      _EcuacionesDeSegundoGradoState();
}

class _EcuacionesDeSegundoGradoState extends State<EcuacionesDeSegundoGrado> {
  double valorA = 0;
  double valorB = 0;
  double valorC = 0;
  double valorD = 0;
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
                  const SizedBox(
                    height: kEspacioTitulos,
                  ),
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.ecuacionesDeSegundoGrado,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .ecuacionesDeSegundoGrado,
                            widgetName: kWidgetEcuacionesDeSegundoGrado),
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
                                        .ecuacionesDeSegundoGrado,
                                    widgetName:
                                        kWidgetEcuacionesDeSegundoGrado),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .ecuacionesDeSegundoGrado,
                                    widgetName:
                                        kWidgetEcuacionesDeSegundoGrado),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"ax^2+bx+c = d"),
                  const SizedBox(height: 20),
                  Math.tex("$valorA x^2+$valorB x+ $valorC =$valorD",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
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
                          labelText: 'a',
                        ),
                        onChanged: (valor) {
                          setState(() {
                            valorA = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
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
                          hintText: "2",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'b',
                        ),
                        onChanged: (valor) {
                          setState(() {
                            valorB = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
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
                          hintText: "10",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'c',
                        ),
                        onChanged: (valor) {
                          setState(() {
                            valorC = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
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
                          hintText: "10",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'd',
                        ),
                        onChanged: (valor) {
                          setState(() {
                            valorD = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  _solucion(valorA, valorB, valorC, valorD),

                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.formulaAplicada,
                    ruta: kRutaFormulaGeneral,
                  ),
                  const SizedBox(height: 30.0),
                  //Todo Agregar video explicativo de como poner la ecuación y como resolverla
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _solucion(valorA, valorB, valorC, valorD) {
    valorC = ((valorC) - (valorD));
    double valorX1 =
        ((-1 * valorB) + sqrt((pow(valorB, 2) - 4 * valorA * valorC))) /
            (2 * (valorA));
    double valorX2 =
        ((-1 * valorB) - sqrt((pow(valorB, 2) - 4 * valorA * valorC))) /
            (2 * (valorA));

    if (valorX1.isNaN || valorX2.isNaN) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kColorBotones,
          border: Border.all(
            width: 10.0,
            color: kColorFondo,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.lasSolucionesSonImaginarias,
                style: kEstiloTextoMenus,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kColorBotones,
          border: Border.all(
            width: 10.0,
            color: kColorFondo,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Center(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioInteractivo),
                    Text(
                      AppLocalizations.of(context)!.soluciones,
                      style: kEstiloTextoMenus,
                    ),
                    const SizedBox(height: kEspacioInteractivo),
                    Text(
                      'X1 = ${implementFraction(valorX1)}\nX2 = ${implementFraction(valorX2)}',
                      style: kEstiloTextoMenus,
                    ),
                    const SizedBox(height: kEspacioInteractivo),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
