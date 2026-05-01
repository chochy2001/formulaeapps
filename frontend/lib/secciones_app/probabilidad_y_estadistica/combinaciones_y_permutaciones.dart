import 'package:flutter/material.dart';
import 'package:formulae/fraccion.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CombinacionesYPermutaciones extends StatefulWidget {
  const CombinacionesYPermutaciones({Key? key}) : super(key: key);

  @override
  CombinacionesYPermutacionesState createState() =>
      CombinacionesYPermutacionesState();
}

class CombinacionesYPermutacionesState
    extends State<CombinacionesYPermutaciones> {
  double n = 0.0, r = 0.0;

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
                  ChatGPTButton(
                    child: TituloPersonalizado(
                      AppLocalizations.of(context)!.combinacionesYPermutaciones,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .combinacionesYPermutaciones,
                            widgetName: kWidgetCombinacionesYPermutaciones),
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
                                        .combinacionesYPermutaciones,
                                    widgetName:
                                        kWidgetCombinacionesYPermutaciones),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .combinacionesYPermutaciones,
                                    widgetName:
                                        kWidgetCombinacionesYPermutaciones),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        Column(
                          children: [
                            const SizedBox(height: kEspacioEntreBotones),
                            TextoEcuaciones(
                              AppLocalizations.of(context)!.combinaciones,
                            ),
                            const SizedBox(height: kEspacioEntreBotones),
                            const Latex(
                                formulaText: r"_nC_r = \frac{n!}{(n-r)!r!}"),
                            const SizedBox(height: kEspacioEntreBotones),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: kEspacioEntreBotones),
                            TextoEcuaciones(
                              AppLocalizations.of(context)!.permutaciones,
                            ),
                            const SizedBox(height: kEspacioEntreBotones),
                            const Latex(
                                formulaText: r"_nP_r = \frac{n!}{(n-r)!}"),
                            const SizedBox(height: kEspacioEntreBotones),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                          labelText: 'n',
                        ),
                        onChanged: (valor) {
                          setState(() {
                            n = double.parse(valor);
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
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'r',
                        ),
                        onChanged: (valor) {
                          setState(() {
                            r = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  _solucionCombinacionesPermutaciones(n, r),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetCombinacionesYPermutaciones,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetCombinacionesYPermutaciones,
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
                        ZoomPersonalizado(
                          child: Column(
                            children: [
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .combinacionesElementos,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _solucionCombinacionesPermutaciones(n, r) {
    double nFactorial = factorial(n);
    double rFactorial = factorial(r);
    double resta = (n - r);
    double combinaciones = nFactorial / ((factorial(resta)) * rFactorial);
    double permutaciones = nFactorial / (factorial(resta));

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
          '${AppLocalizations.of(context)!.combinaciones}=\n${implementFraction(combinaciones)}\n${AppLocalizations.of(context)!.permutaciones}=\n${implementFraction(permutaciones)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }
}

double factorial(double numero) {
  double factorial = 1;
  for (int i = 1; i <= numero; i++) {
    factorial = factorial * i;
  }
  return factorial;
}
