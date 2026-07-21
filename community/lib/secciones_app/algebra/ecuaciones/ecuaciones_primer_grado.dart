import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';

import '../../../../constantes/export_constantes.dart';

class EcuacionesDePrimerGrado extends StatefulWidget {
  const EcuacionesDePrimerGrado({super.key});

  @override
  State<EcuacionesDePrimerGrado> createState() =>
      _EcuacionesDePrimerGradoState();
}

class _EcuacionesDePrimerGradoState extends State<EcuacionesDePrimerGrado> {
  double valorA = 0;
  double valorB = 0;
  double valorC = 0;

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.ecuacionesDePrimerGrado,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.ecuacionesDePrimerGrado,
                          widgetName: kWidgetEcuacionesDePrimerGrado,
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
                                  )!.ecuacionesDePrimerGrado,
                                  widgetName: kWidgetEcuacionesDePrimerGrado,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.ecuacionesDePrimerGrado,
                                  widgetName: kWidgetEcuacionesDePrimerGrado,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  const Latex(formulaText: r"ax+ b = c"),
                  const SizedBox(height: kBordeBotones),
                  Latex(formulaText: "$valorA x+$valorB=$valorC"),
                  const SizedBox(height: 20),
                  const SizedBox(height: kBordeBotones),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
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
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
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
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
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
                  const SizedBox(height: kEspacioEntreBotones + 10),
                  _solucion(valorA, valorB, valorC),
                  //Todo Agregar video explicativo de como poner la ecuación
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _solucion(valorA, valorB, valorC) {
    double valorX = (valorC - valorB) / valorA;
    double valorMultiplicacion = valorA * valorX;
    double valorSuma = valorB + valorMultiplicacion;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(width: 10.0, color: kColorFondo),
      ),
      child: Column(
        children: [
          ListTile(
            title: Center(
              child: Text(
                "\n${AppLocalizations.of(context)!.solucion}\nX = ${implementFraction(valorX)}\n",
                style: kEstiloTextoMenus,
              ),
            ),
          ),
          Latex(
            formulaText:
                "(${implementFraction(valorA)} * ${implementFraction(valorX)})",
          ),
          const SizedBox(height: 10),
          Latex(
            formulaText:
                "+ ${implementFraction(valorB)}=${implementFraction(valorC)}",
          ),
          const SizedBox(height: 15),
          Latex(
            formulaText:
                "${implementFraction(valorMultiplicacion)}+${implementFraction(valorB)}",
          ),
          const SizedBox(height: 10),
          Latex(formulaText: "=${implementFraction(valorC)}"),
          const SizedBox(height: 15),
          Latex(
            formulaText:
                "${implementFraction(valorSuma)}=${implementFraction(valorC)}",
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
