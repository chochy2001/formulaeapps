import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class PuntoMedioEntreDosPuntosGeometria extends StatefulWidget {
  const PuntoMedioEntreDosPuntosGeometria({super.key});
  @override
  State<PuntoMedioEntreDosPuntosGeometria> createState() =>
      _PuntoMedioEntreDosPuntosGeometriaState();
}

class _PuntoMedioEntreDosPuntosGeometriaState
    extends State<PuntoMedioEntreDosPuntosGeometria> {
  double x1 = 0.0, y1 = 0.0, x2 = 0.0, y2 = 0.0;

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
                    AppLocalizations.of(context)!.puntoMedioEntreDosPuntos,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.puntoMedioEntreDosPuntos,
                          widgetName: kWidgetPuntoMedioEntreDosPuntos,
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
                                  )!.puntoMedioEntreDosPuntos,
                                  widgetName: kWidgetPuntoMedioEntreDosPuntos,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.puntoMedioEntreDosPuntos,
                                  widgetName: kWidgetPuntoMedioEntreDosPuntos,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  const Latex(
                    formulaText:
                        r"M=\left(\frac{x_1+x_2}{2},\frac{y_1+y_2}{2},\frac{z_1+z_2}{2}\right)",
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
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
                        labelText: 'x1',
                      ),
                      onChanged: (valor) {
                        setState(() {
                          x1 = double.parse(valor);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30.0),

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
                        labelText: 'y1',
                      ),
                      onChanged: (valor) {
                        setState(() {
                          y1 = double.parse(valor);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30.0),
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
                        labelText: 'x2',
                      ),
                      onChanged: (valor) {
                        setState(() {
                          x2 = double.parse(valor);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30.0),
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
                        labelText: 'y2',
                      ),
                      onChanged: (valor) {
                        setState(() {
                          y2 = double.parse(valor);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30.0),

                  Math.tex(
                    "(${implementFraction(x1)},${implementFraction(y1)}),(${implementFraction(x2)},${implementFraction(y2)})",
                    mathStyle: MathStyle.display,
                    textStyle: kTextoLatexFormulas,
                  ),
                  _solucionPuntoMedio(x1, x2, y1, y2),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetPuntoMedioEntreDosPuntos),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetPuntoMedioEntreDosPuntos),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(color: kColorFondo, width: 8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        TextoEcuaciones(
                          '${AppLocalizations.of(context)!.encuentraPuntoMedioEntre}\n( –2, 5 )  y  ( 7, 7 ).',
                        ),
                        const SizedBox(height: 10.0),
                        const Latex(
                          formulaText:
                              r"\left(\frac{-2+7}{2},\frac{5+7}{2}\right)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.simplificando,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"\left(\frac{5}{2},\frac{12}{2}\right)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"\left(\frac{5}{2},\frac{6}{1}\right)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(2.5,6)"),
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

  Widget _solucionPuntoMedio(x1, x2, y1, y2) {
    double puntoX = ((x1 + x2) / 2);
    double puntoY = ((y1 + y2) / 2);

    return Container(
      color: kColorBotones,
      child: ListTile(
        title: Text(
          '${AppLocalizations.of(context)!.puntoMedio}=\n(${implementFraction(puntoX)},${implementFraction(puntoY)})',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }
}
