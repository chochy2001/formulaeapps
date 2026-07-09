import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class OperacionesFraccionesAlgebraicas extends StatefulWidget {
  @override
  _OperacionesFraccionesAlgebraicasState createState() =>
      _OperacionesFraccionesAlgebraicasState();
}

class _OperacionesFraccionesAlgebraicasState
    extends State<OperacionesFraccionesAlgebraicas> {
  double numeradorA = 0.0,
      numeradorC = 0.0,
      denominadorB = 0.0,
      denominadorD = 0.0;
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!
                        .operacionesFraccionesAlgebraicas,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .operacionesFraccionesAlgebraicas,
                            widgetName:
                                kWidgetOperacionesConFraccionesAlgebraicas),
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
                                        .operacionesFraccionesAlgebraicas,
                                    widgetName:
                                        kWidgetOperacionesConFraccionesAlgebraicas),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .operacionesFraccionesAlgebraicas,
                                    widgetName:
                                        kWidgetOperacionesConFraccionesAlgebraicas),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: kEspacioEntreBotones,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Suma
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.adicion,
                        ),

                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"\frac{a}{b}+\frac{c}{d}=\frac{ad}{bd}+\frac{cb}{bd}=\frac{ad+cb}{bd}"),

                        const SizedBox(height: 10),
                        //ignore_for_file: prefer_interpolation_to_compose_strings
                        Latex(
                            formulaText: r"\frac{" +
                                numeradorA.toString() +
                                "}{" +
                                denominadorB.toString() +
                                r"}+\frac{" +
                                numeradorC.toString() +
                                "}{" +
                                denominadorD.toString() +
                                r"}=\frac{" +
                                (numeradorA * denominadorD).toString() +
                                "}{" +
                                (denominadorB * denominadorD).toString() +
                                r"}+\frac{" +
                                (numeradorC * denominadorB).toString() +
                                "}{" +
                                (denominadorB * denominadorD).toString() +
                                r"}=\frac{" +
                                (numeradorA * denominadorD +
                                        numeradorC * denominadorB)
                                    .toString() +
                                "}{" +
                                (denominadorB * denominadorD).toString() +
                                r"}"),

                        const SizedBox(
                          height: kEspacioEntreBotones,
                        ),
                        //Resta
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sustraccion,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"\frac{a}{b}-\frac{c}{d}=\frac{ad}{bd}-\frac{cb}{bd}=\frac{ad-cb}{bd}"),

                        const SizedBox(height: 10),
                        Latex(
                            formulaText: r"\frac{" +
                                numeradorA.toString() +
                                "}{" +
                                denominadorB.toString() +
                                r"}-\frac{" +
                                numeradorC.toString() +
                                "}{" +
                                denominadorD.toString() +
                                r"}=\frac{" +
                                (numeradorA * denominadorD).toString() +
                                "}{" +
                                (denominadorB * denominadorD).toString() +
                                r"}-\frac{" +
                                (numeradorC * denominadorB).toString() +
                                "}{" +
                                (denominadorB * denominadorD).toString() +
                                r"}=\frac{" +
                                (numeradorA * denominadorD -
                                        numeradorC * denominadorB)
                                    .toString() +
                                "}{" +
                                (denominadorB * denominadorD).toString() +
                                r"}"),

                        const SizedBox(
                          height: kEspacioEntreBotones,
                        ),
                        //Multiplicacion
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.multiplicacion,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"\frac{a}{b}\cdot\frac{c}{d}=\frac{ac}{bd}"),

                        const SizedBox(height: 10),

                        Latex(
                            formulaText: r"  \frac{" +
                                numeradorA.toString() +
                                "}{" +
                                denominadorB.toString() +
                                r"}\cdot\frac{" +
                                numeradorC.toString() +
                                "}{" +
                                denominadorD.toString() +
                                r"}=\frac{" +
                                (numeradorA * numeradorC).toString() +
                                "}{" +
                                (denominadorB * denominadorD).toString() +
                                r"}    "),

                        const SizedBox(
                          height: kEspacioEntreBotones,
                        ),
                        //División
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.division,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"\frac{a}{b}\div\frac{c}{d}=\frac{ad}{bc}=\frac{a}{b}\left(\frac{d}{c}\right)"),

                        const SizedBox(height: 10),

                        Latex(
                            formulaText: r"\frac{" +
                                numeradorA.toString() +
                                "}{" +
                                denominadorB.toString() +
                                r"}\div\frac{" +
                                numeradorC.toString() +
                                "}{" +
                                denominadorD.toString() +
                                r"}=\frac{" +
                                (numeradorA * denominadorD).toString() +
                                "}{" +
                                (denominadorB * numeradorC).toString() +
                                r"}=\frac{" +
                                numeradorA.toString() +
                                "}{" +
                                denominadorB.toString() +
                                r"}\left(\frac{" +
                                denominadorD.toString() +
                                "}{" +
                                numeradorC.toString() +
                                r"}\right)"),

                        const SizedBox(height: 30.0),
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
                            width: MediaQuery.of(context).size.width *
                                interactiveWidth,
                            child: TextField(
                              style: kTextoBotones,
                              cursorColor: Colors.white,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                                  numeradorA = double.parse(valor);
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
                            width: MediaQuery.of(context).size.width *
                                interactiveWidth,
                            child: TextField(
                              style: kTextoBotones,
                              cursorColor: Colors.white,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                                labelText: 'b',
                              ),
                              onChanged: (valor) {
                                setState(() {
                                  denominadorB = double.parse(valor);
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
                            width: MediaQuery.of(context).size.width *
                                interactiveWidth,
                            child: TextField(
                              style: kTextoBotones,
                              cursorColor: Colors.white,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                                labelText: 'c',
                              ),
                              onChanged: (valor) {
                                setState(() {
                                  numeradorC = double.parse(valor);
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
                            width: MediaQuery.of(context).size.width *
                                interactiveWidth,
                            child: TextField(
                              style: kTextoBotones,
                              cursorColor: Colors.white,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                                labelText: 'd',
                              ),
                              onChanged: (valor) {
                                setState(() {
                                  denominadorD = double.parse(valor);
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: kEspacioInteractivo),
                        _solucionFracciones(
                            numeradorA, numeradorC, denominadorB, denominadorD),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetOperacionesConFraccionesAlgebraicas,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetOperacionesConFraccionesAlgebraicas,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _solucionFracciones(
      numeradorA, numeradorC, denominadorB, denominadorD) {
    double fraccion1 = numeradorA / denominadorB;
    double fraccion2 = numeradorC / denominadorD;
    double suma = fraccion1 + fraccion2;
    double resta = fraccion1 - fraccion2;
    double multiplicacion = fraccion1 * fraccion2;
    double division = fraccion1 / fraccion2;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(
          width: 10.0,
          color: kColorFondo,
        ),
      ),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: ListTile(
            title: Text(
              ' ${AppLocalizations.of(context)!.adicion} = ${implementFraction(suma)}\n${AppLocalizations.of(context)!.sustraccion} = ${implementFraction(resta)}\n${AppLocalizations.of(context)!.multiplicacion} = ${implementFraction(multiplicacion)}\n${AppLocalizations.of(context)!.division}= ${implementFraction(division)}',
              style: kEstiloTextoMenus,
            ),
          ),
        ),
      ),
    );
  }
}
